From: giuseppe.condorelli@st.com (Giuseppe CONDORELLI)
Date: Fri, 13 Jun 2014 13:23:14 +0000
Subject: Latest mainline (3.16 merge window) does not boot in B2020/STiH416
In-Reply-To: <539AF5B0.6060509@linaro.org>
References: <539AF5B0.6060509@linaro.org>
Message-ID: <DB9CA98AC012DF4FBF9AF41C875BCE91CC449A@SAFEX1NODE23.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

what type of messages you have?
Is it a networking issue?

About the inquired patch, as you can easily see via git log, the code
introduced is disabled by default, so I think the keyscan support can be
excluded from the "black" list.
Indeed, if for whatever reason it was enabled and Ethernet disabled (given that its PIOs
conflict with the second ones) it could be a reason of your failures.
One test you can do, other than to check the dt code, is to boot via a usb network cable and
see if the boards mount the nfs filesystem.

Cheers,
Giuseppe

>-----Original Message-----
>From: Daniel Thompson [mailto:daniel.thompson at linaro.org]
>Sent: venerd? 13 giugno 2014 14:59
>To: Gabriel FERNANDEZ
>Cc: Giuseppe CONDORELLI; Gabriel Fernandez; Maxime COQUELIN; Srinivas
>Kandagatla; Patrice CHOTARD; linux-arm-kernel at lists.infradead.org;
>kernel at stlinux.com
>Subject: Latest mainline (3.16 merge window) does not boot in B2020/STiH416
>
>Hi Folks
>
>Using the lastest Linus T. mainline it is no longer possible to boot a
>B2020/STiH416.
>
>The kernel boots OK and issues UART messages, but the system gets stuck
>trying to mount the NFS root filesystem.
>
>Configuration is multi_v7_defconfig+CGROUPS+AUTOFS4_FS+IPV6 (although
>the deviations from multi_v7_defconfig should make little difference).
>
>An automated bisect identified the first broken version as:
>--- cut here ---
>commit 948d8ffb4775705c729501f9a433d05163e2f253
>Author: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
>Date:   Fri Apr 11 17:07:00 2014 +0200
>
>    ARM: STi: DT: add keyscan for stih416
>
>    Add keyscan support for stih416.
>    It is disabled by default given that it is not enabled on all boards.
>    Also there are PIOs conflict with already claimed lines.
>
>    Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>    Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
>    Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>    Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
>--- cut here ---
>
>Unfortunately 'git revert 948d8ffb4775705c729501f9a433d05163e2f253' is
>insufficient to get things working when merged back to head.
>
>Feel free to ask for any help in resolving the problem.
>
>
>Daniel.
