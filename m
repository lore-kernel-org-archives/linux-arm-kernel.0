From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 5 Aug 2016 19:22:43 -0700
Subject: [PATCH v3] input: touchscreen: Remove duplicate ft6236 driver
In-Reply-To: <72101a2a-ccf0-b0bc-3859-50a43f990027@i2se.com>
References: <1470381871-4086-1-git-send-email-hdegoede@redhat.com>
 <1470381871-4086-2-git-send-email-hdegoede@redhat.com>
 <72101a2a-ccf0-b0bc-3859-50a43f990027@i2se.com>
Message-ID: <20160806022243.GB20562@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2016 at 05:07:20PM +0200, Stefan Wahren wrote:
> Hi Hans,
> 
> Am 05.08.2016 um 09:24 schrieb Hans de Goede:
> >The new(ish) ft6236 simply re-implements the M09 protocol of the
> >(much) older edt-ft5x06.c driver.
> >
> >This commit removes this duplicate driver and adds the i2c ids and
> >dt compatible string to the edt-ft5x06.c driver to keep compatibility.
> 
> i think only remove of the driver is incorrect here.
> 
> Since there are two similar but still different DT bindings
> 
> Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> 
> Documentation/devicetree/bindings/input/touchscreen/focaltech-ft6236.txt
> 
> the DT handling of edt-ft5x06.c needs to be extended and then
> finally driver and binding could be removed.

I believe Hans made sure edt-ft5x06.c can handle focaltech-ft6236
bindings. Do you see a discrepancy?

Thanks.

-- 
Dmitry
