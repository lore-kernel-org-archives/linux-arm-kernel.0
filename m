From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 5 Aug 2016 17:07:20 +0200
Subject: [PATCH v3] input: touchscreen: Remove duplicate ft6236 driver
In-Reply-To: <1470381871-4086-2-git-send-email-hdegoede@redhat.com>
References: <1470381871-4086-1-git-send-email-hdegoede@redhat.com>
 <1470381871-4086-2-git-send-email-hdegoede@redhat.com>
Message-ID: <72101a2a-ccf0-b0bc-3859-50a43f990027@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

Am 05.08.2016 um 09:24 schrieb Hans de Goede:
> The new(ish) ft6236 simply re-implements the M09 protocol of the
> (much) older edt-ft5x06.c driver.
>
> This commit removes this duplicate driver and adds the i2c ids and
> dt compatible string to the edt-ft5x06.c driver to keep compatibility.

i think only remove of the driver is incorrect here.

Since there are two similar but still different DT bindings

Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt

Documentation/devicetree/bindings/input/touchscreen/focaltech-ft6236.txt

the DT handling of edt-ft5x06.c needs to be extended and then finally 
driver and binding could be removed.

Regards
Stefan
