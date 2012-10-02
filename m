From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Oct 2012 15:43:22 +0300
Subject: [PATCHv3 1/4] mfd: smsc: Add support for smsc gpio io/keypad
 driver
In-Reply-To: <20121002123856.GX4360@opensource.wolfsonmicro.com>
References: <1349089282-22105-1-git-send-email-sourav.poddar@ti.com>
 <CAAe_U6+zEGuwMC1yn7O=LXE6PhPvPc2i7DCF0EAprkE8s+-iEw@mail.gmail.com>
 <20121001114454.GA9170@sirena.org.uk>
 <CAAe_U6JX9QDWvWA3KH7E9sOv0EHGkozVONuXDgn+a2MZ4GTE7Q@mail.gmail.com>
 <20121001120907.GK4360@opensource.wolfsonmicro.com>
 <CAAe_U6K6nAjsZUOk2rBFweWHtJmcLF7EJDpu9O6FXrq3tzv3yg@mail.gmail.com>
 <20121002123856.GX4360@opensource.wolfsonmicro.com>
Message-ID: <20121002124321.GD30762@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

coming late to the discussion, so bear with me

On Tue, Oct 02, 2012 at 01:38:56PM +0100, Mark Brown wrote:
> > This means mfd framework does not have an API to create a device from
> > dt data or so do I think since of_platform_populate() is used. Thats
> > why I suggested the idea of extending mfd_add_devices() (or adding a
> > new API in mfd framework) to create child devices from dt data so that
> > we'll have API's in mfd framework to both create and delete a device.
> 
> The trouble that always exists with representing MFD children in DT is
> that unless you've got a usefully reusable IP block which is clearly
> separate from the chip integration you end up essentially just dumping
> the Linux data structures into DT which often doesn't leave you with
> something which describes the hardware.

do you mean to say that children creation should be left into the driver
(outside dt) ? That should be doable, indeed.

BTW, OTOH writing all children into the DT actually describes the HW,
no ? And depending on the device I feel it'd be better to write that
data to DT. Think of twlxxxx (TI's PMICs), we might have completely
unrelated drivers using one of TWL's GPIO lines as an interrupt source.

If that particular children isn't listed in DT, it can't be used as an
interrupt-parent, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121002/a5cf6283/attachment.sig>
