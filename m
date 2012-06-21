From: robherring2@gmail.com (Rob Herring)
Date: Thu, 21 Jun 2012 16:32:26 -0500
Subject: [Patch v5 08/13] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <20120620150502.GG2253@S2101-09.ap.freescale.net>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-9-git-send-email-richard.zhao@freescale.com>
 <4FD8AD42.6010702@gmail.com> <20120613152841.GA23590@richard-laptop>
 <4FD8C4DB.4020908@gmail.com>
 <20120614013343.GD29684@b20223-02.ap.freescale.net>
 <4FE1DE53.4070202@gmail.com>
 <20120620150502.GG2253@S2101-09.ap.freescale.net>
Message-ID: <4FE392EA.7060103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2012 10:05 AM, Shawn Guo wrote:
> On Wed, Jun 20, 2012 at 09:29:39AM -0500, Rob Herring wrote:
>> I mean just something like "fsl,hub-reset-gpios" in the ehci device
>> node. It's at least under a usb node. Whether the ehci driver handles
>> this or you just have a separate piece of code to find this property and
>> setup the gpio is up to you.
>>
> I ever had an argument on this.  If we have "fsl,hub-reset-gpios"
> defined in ehci device node, it should simply be ehci driver who needs
> to find this property and set up the gpio.  Defining the property in
> ehci device node while having platform code to find the property just
> seems wired to me.  That said, if it's not ehci driver who will use
> the property, we should not define the property in in ehci device node.

There's no requirement that 1 DT node be 1 driver. That's purely an OS
decision and it's usually simpler that way. But if it it's just a one
time thing at boot, then its fine for the platform code to handle it.

Rob
