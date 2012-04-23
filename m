From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 23 Apr 2012 17:05:48 +0530
Subject: [PATCH V2] watchdog: mpcore: Add DT probing support for ARM
 mpcore watchdog
In-Reply-To: <4F9514AA.10403@arm.com>
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
 <7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com>
 <4F9514AA.10403@arm.com>
Message-ID: <CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 2:06 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Irk! Have you actually tested this?

Yes. But with incorrect base address. I passed timers address by mistake.

> The DT binding indicates:
> - reg : Specify the base address and the size of the TWD watchdog
> ? ? ? ?register window.
>
> while all the offsets in smp_twd.h are expressed in bytes from the TWD
> *timer* base. So you have to either fix these offsets (which breaks
> potential users of the non-DT version of the driver), or correct the
> base when using DT.

You are correct. Which one do you prefer:
- Change bindings to pass timers base address
- subtract 0x20 from base address for DT case
- something else.

--
viresh
