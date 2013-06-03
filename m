From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon, 03 Jun 2013 09:56:51 +0100
Subject: [PATCH v1 2/2] ARM:prima2:move postcore_initcalls to init_machine.
In-Reply-To: <CAGsJ_4yu2MT5o7hbX67KPhrejS9D1BbPcship4zxtXs3G9tE-Q@mail.gmail.com>
References: <1369993439-24216-1-git-send-email-srinivas.kandagatla@st.com>
 <1369993517-24735-1-git-send-email-srinivas.kandagatla@st.com>
 <CAGsJ_4yu2MT5o7hbX67KPhrejS9D1BbPcship4zxtXs3G9tE-Q@mail.gmail.com>
Message-ID: <51AC5A53.1090700@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/13 04:51, Barry Song wrote:
> did you see this one?
> 
> [PATCH v2] arm: prima2: use of_platform_populate instead of
> of_platform_bus_probe
> http://www.spinics.net/lists/arm-kernel/msg243710.html

Yes, I think this is a nice cleanup for simplest case. But Prima
platforms do much more checking at the same init level. An attempt to
get rid of postcore and early init calls might introduce this back.

You could solve both the early and postcore initcall issues by returning
instead of panic, and let every NON Prima platforms call this function.
Or
Do it the right way and clean it up.

I will leave it up to you to decide on how you want to fix the multi_v7
kernel issue.

Thanks,
srini
