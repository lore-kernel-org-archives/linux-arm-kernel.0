From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 31 Jul 2011 10:09:03 +0100
Subject: [PATCH 11/18] dmaengine/amba-pl08x: max_bytes_per_lli is
	TRANSFER_SIZE * src_width (not MIN(width))
In-Reply-To: <CAKnu2MpUj9JDDg8psPf5WaGGFSZGmPcmtiujKiFzcHM71RqLKQ@mail.gmail.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<5521ee74eef41cf26a9f1ece6dadd32cca529cce.1311936524.git.viresh.kumar@st.com>
	<CAKnu2MpUj9JDDg8psPf5WaGGFSZGmPcmtiujKiFzcHM71RqLKQ@mail.gmail.com>
Message-ID: <20110731090903.GB30888@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 31, 2011 at 02:27:38AM +0200, Linus Walleij wrote:
> 2011/7/29 Viresh Kumar <viresh.kumar@st.com>:
> 
> > max_bytes_per_lli = bd.srcbus.buswidth * PL080_CONTROL_TRANSFER_SIZE_MASK;
> > This is confirmed by ARM support guys.
> 
> Great and THANKS for your tiresome research in ironing out the ambiguities
> in the manuals.

The manual isn't that bad.  The code from ARM though is, and raises lots
of "why are they doing that?  oh, they must know better than the docs"
type questions.  Obviously they don't!
