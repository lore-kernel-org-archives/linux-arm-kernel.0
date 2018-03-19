From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 11:23:55 -0700
Subject: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
 driver
In-Reply-To: <DM2PR0201MB0767FFBAECF3A0B30251DBB8B8D20@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-3-git-send-email-jollys@xilinx.com>
 <20180306014549.6t3ae5adzc3cpi5v@rob-hp-laptop>
 <DM2PR0201MB0767031248A9F773620722FDB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <CAL_JsqKUC47xB5O2Y6c3efVCjJY=V+XO3xyLTU9rNia40bdZkg@mail.gmail.com>
 <DM2PR0201MB0767FFBAECF3A0B30251DBB8B8D20@DM2PR0201MB0767.namprd02.prod.outlook.com>
Message-ID: <152148383577.242365.14896728603053993045@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jolly Shah (2018-03-13 11:39:13)
> Hi Rob,
> > 
> > What is the interface to the "platform management controller"? Because you
> > have no registers, I'm guessing a firmware interface? If so, then just define the
> > firmware node as a clock provider.
> 
> Yes it is firmware interface. Along with clocks, firmware interface also controls power and pinctrl operations as major.
> I am not sure if I understand you correctly. Do you suggest to register clocks through Firmware driver or just use firmware DT node as clock provider and clock driver DT node can reference clocks from FW node to register same?

I would suggest making the firmware driver register the clks and act as
the clk provider. Not sure what Rob wants.
