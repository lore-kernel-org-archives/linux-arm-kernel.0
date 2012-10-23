From: mporter@ti.com (Matt Porter)
Date: Mon, 22 Oct 2012 21:53:46 -0400
Subject: OMAP baseline test results for v3.7-rc2
In-Reply-To: <50859505.5010306@ti.com>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
 <50857444.9080308@ti.com>
 <alpine.DEB.2.00.1210221829270.13464@utopia.booyaka.com>
 <50859505.5010306@ti.com>
Message-ID: <20121023015346.GB1855@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 01:48:37PM -0500, Jon Hunter wrote:
> 
> On 10/22/2012 01:35 PM, Paul Walmsley wrote:
> > (including the lists in my reply this time, oops; also adding some more 
> > detail)
> > 
> > On Mon, 22 Oct 2012, Jon Hunter wrote:
> > 
> >> On 10/20/2012 04:26 PM, Paul Walmsley wrote:
> >>
> >>> Failing tests: fixed by posted patches
> >>> --------------------------------------
> >>>
> >>> Boot tests:
> >>>
> >>> * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
> >>>   - due to a GPMC bug
> >>>   - Apparently fixed by http://www.spinics.net/lists/arm-kernel/msg200787.html
> >>
> >> This is now addressed and I have verified it is booting on v3.7-rc2. The
> >> following patch address this boot problem ...
> >>
> >> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8119024ef7363591fd958ec89ebfaee7c18209e3
> > 
> > Great, thanks, will update the README.  Did you also enable 
> > CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT, or were you able 
> > to pass the DTB from the bootloader?
> 
> Actually, I built u-boot release 2012.10 for the am335x-evm and that
> worked for the bone board too. So that is what I used. I have not
> checked with Vaibhav and team if that is what they are using. So with
> this u-boot I just passed the dtb to the kernel and did not append.

I've mentioned this a few times in various threads...no need to use
appended DTB on a current U-Boot. Some of us are indeed booting this way
with the DTB properly passed separately from the bootloader and chosen
filled out by the bootloader. And yes, am335x_evm_config applies to all
AM33xx TI EVMs and the BeagleBone board. There's an EEPROM onboard all
that is used to determine what board is present so a single
MLO/u-boot.img can be used.

BTW, if you pick up an RS-232 cape, you can avoid using the FTDI->UART0
connection for console and switch to any UART brought out on the Bone
connectors. This is useful for those using a power controller and
console server for local automated testing.

-Matt
