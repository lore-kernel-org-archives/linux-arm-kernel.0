From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 17 Jan 2012 15:17:20 -0200
Subject: [PATCH] ARM: clock-mx28: Fix end of loop condition
In-Reply-To: <CAOMZO5CAkP4ugh-nLU=wqBPXTNePuxerWugd_tKxB3TDQ+0dsg@mail.gmail.com>
References: <1326740477-21576-1-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5B1ABUr1bqW8f_YLjtE46DBkFt1HocZVziv0barHq1TJg@mail.gmail.com>
 <201201162152.59997.marek.vasut@gmail.com>
 <CAOMZO5BQ1BCdf2HkUXG55dtfUk-4sSZE6TqnZ+gO9zwXVWt5vw@mail.gmail.com>
 <CAOMZO5CAkP4ugh-nLU=wqBPXTNePuxerWugd_tKxB3TDQ+0dsg@mail.gmail.com>
Message-ID: <CAOMZO5BTGgQ80_gfLQqu5LBuuo=vdYCL2ChkKFLN6z5fMTQ2UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/17/12, Fabio Estevam <festevam@gmail.com> wrote:
> On 1/16/12, Fabio Estevam <festevam@gmail.com> wrote:
>
>> I will make more tests to confirm and post a new patch.
>
> On my tests I am always getting the BUSY bit of HW_CLKCTRL_SAIF0 as 1,
> no matter the timeout I add.
>
> BUSY bit is bit 29 of this register and matches the mx28 reference
> manual description.
>
> Looking at the Freescale kernel this BUSY bit is defined as 1 instead.

Not really, I looked at the wrong register.

The issue can be solved by clearing CLKGATE bit prior to writing to
DIV field, as described in the mx28 reference manual.

Just sent the updated patch that allows audio to work on mx28.

Regards,

Fabio Estevam
