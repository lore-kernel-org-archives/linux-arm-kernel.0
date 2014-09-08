From: balbi@ti.com (Felipe Balbi)
Date: Mon, 8 Sep 2014 08:24:03 -0500
Subject: [PATCH 2/2] ARM: dts: omap5: Add dr_mode for dwc3
In-Reply-To: <540D9449.3090008@compulab.co.il>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
 <1381402195-29257-2-git-send-email-kishon@ti.com>
 <52580F34.8030809@ti.com> <20140416161619.GH28035@saruman.home>
 <540D9449.3090008@compulab.co.il>
Message-ID: <20140908132403.GA22409@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 08, 2014 at 02:34:33PM +0300, Dmitry Lifshitz wrote:
> Hi Felipe, Roger
> 
> On 04/16/2014 07:16 PM, Felipe Balbi wrote:
> >On Fri, Oct 11, 2013 at 05:46:12PM +0300, Roger Quadros wrote:
> >>Hi,
> >>
> >>On 10/10/2013 01:49 PM, Kishon Vijay Abraham I wrote:
> >>>From: George Cherian <george.cherian@ti.com>
> >>>
> >>>Added dr_mode property in dwc3 and set its default mode to device.
> >>
> >>If there is a specific reason why this is not set to "otg", we need
> >>to explain it here.
> >>
> >>AFAIK the port is meant to be used as OTG port.
> >
> >we still don't have the workaround for dual role ports, I've been
> >working on it but still need to retest and make sure it's working fine
> >before merging upstream.
> >
> 
> 
> Does the OTG port suppose to work with OMAP5? I mean role switching
> mechanism?
> 
> I'm testing kernel v3.16 with OMAP5 based board (CM-T54).
> 
> If I set CONFIG_USB_DWC3_DUAL_ROLE, than nothing is going on when I plug
> some device/host cable into micro USB3.0 port (VBUS/ID detection with extcon
> events works fine).

Dual role does not work. We allow the driver to the built with both Host
and Peripheral support because some platforms have more than one port
and building the driver with dual role allows us to make one port host
and one peripheral.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140908/5ab8a951/attachment.sig>
