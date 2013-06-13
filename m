From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jun 2013 12:56:40 +0100
Subject: [PATCH v2 06/11] ARM:stixxxx: Add STiH415 SOC support
In-Reply-To: <51B6C8B7.50807@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856381-6644-1-git-send-email-srinivas.kandagatla@st.com>
 <CAHTX3d+dk3W_9b7SVUokWq4KYXnj=Z1=WPj5zJ-gUvJqqwE=+Q@mail.gmail.com>
 <51B5BCB3.3060405@st.com> <20130610231934.GG18614@n2100.arm.linux.org.uk>
 <51B6C8B7.50807@st.com>
Message-ID: <20130613115640.GC18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 07:50:31AM +0100, Srinivas KANDAGATLA wrote:
> You are right, It does not make sense to use BIT() macro for field which
> has more than 1 bit. I think using mix of both BIT() and the old style
> will make code look bit confusing to reader, Also no other mach code in
> the kernel use BIT while configuring L2 controller. So am going to drop
> the idea of using BIT here and leave the code as it is.

I'd suggest putting a comment in the code to that effect.  With the way
"cleanups" get done, I wouldn't be surprised if this attracts a lot of
people wanting to do a trivial "1 << bit" -> "BIT(bit)" conversions.

One of the problems of open source is that you can say "no" to a patch
like that until you're blue in the face, but it will eventually make
its way in via some path.

Just one of the reasons I consider BIT() to be evil and an inappropriate
macro.
