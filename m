From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 02 Oct 2018 11:57:48 +0100
Subject: [PATCH v6 00/14] Add System Error Interrupt support to Armada SoCs
In-Reply-To: <20181001141358.31508-1-miquel.raynal@bootlin.com>
References: <20181001141358.31508-1-miquel.raynal@bootlin.com>
Message-ID: <86a7nwvcnn.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 01 Oct 2018 15:13:44 +0100,
Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> The ICU is an IRQ chip found in Armada CP110. It currently has 207 wired
> inputs. Its purpose is to aggregate all CP interrupts and report them to
> the AP through MSIs. The ICU writes into GIC registers (AP side) by way
> of the interconnect. These interrupts can be of several groups:
> - SecuRe (SR);
> - Non-SecuRe (NSR);
> - System Error Interrupts (SEI);
> - RAM Error Interrupts (REI);
> - ...
> Each ICU wired interrupt can be of any of these groups. The group is
> encoded in the MSI payload.

[...]

I'm now ready to queue patches 1 through to 11 (with patches 6 and 9
as of v7). Who is picking up the DT patches (12 to 14)?

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
