From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 21 Apr 2016 02:16:22 +0200
Subject: [PATCH V2] acpi: implement Generic Event Device
In-Reply-To: <1454857231-21388-1-git-send-email-okaya@codeaurora.org>
References: <1454857231-21388-1-git-send-email-okaya@codeaurora.org>
Message-ID: <9220738.hpb0S9FjMY@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, February 07, 2016 10:00:31 AM Sinan Kaya wrote:
> Generic Event Device described in ACPI 6.1 allows platforms to handle
> platform interrupts in ACPI ASL statements. It borrows constructs like
> _EVT from GPIO events. All interrupts are listed in _CRS and the handler
> is written in _EVT method. Here is an example.
> 
> Device (GED0)
> {
> 
> 	Name (_HID, "ACPI0013")
> 	Name (_UID, 0)
> 	Name(_CRS, ResourceTemplate ()
> 	{
> 		Interrupt(ResourceConsumer, Edge, ActiveHigh, Shared, , , )
> 		 {123}
> 	})
> 
> 	Method (_EVT, 1) {
> 		if (Lequal(123, Arg0))
> 		{
> 		}
> 	}
> }
> 
> Wake capability has not been implemented yet.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied, thanks!
