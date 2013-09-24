From: sre@ring0.de (Sebastian Reichel)
Date: Tue, 24 Sep 2013 22:50:27 +0200
Subject: [PATCH 4/4] RX-51: Add platform function and data for bq24150a
 charger
In-Reply-To: <201309241905.48301@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309232206.47391@pali> <20130923204714.GB22995@earth.universe>
 <201309241905.48301@pali>
Message-ID: <20130924205026.GA13204@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 24, 2013 at 07:05:47PM +0200, Pali Roh?r wrote:
> No, isp1704 driver is doing fastcharger detection (and then 
> export charger type via sysfs power supply) based on musb usb 
> events.
> 
> Real charging (enabling/disabling and setting properties) is done 
> by bq24150a chip which has own power driver bq2415x_charger.
> 
> As already wrote this is not simple and this is reason why I sent 
> board data and functions only now...

Yes, I'm aware of this. Technically the isp1704 does not provide the
5 volt line, but for the system as a whole that fact does not really
matter.

The isp1704 can provide its functionality via the regulator API
as a simple regulator device. It provides information about the
power "it can supply".

The bq24150a on the other hand can just use the regulator via the
consumer interface.

The regulator framework provides capabilities for events:
"Regulators can notify consumers of external events"

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130924/649da08c/attachment.sig>
