From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 30 Jun 2013 12:45:44 +0400
Subject: =?UTF-8?B?UmVbNF06IFtQQVRDSCB2MyAxLzVdIHJ0YzogbXhjX3J0YzogRHJpdmVyIHJl?=
 =?UTF-8?B?IHdvcms=?=
In-Reply-To: <20943.61307.796422.302951@ipc1.ka-ro>
References: <1372495244-21215-1-git-send-email-shc_work@mail.ru>
 <1372580813.432068011@f179.mail.ru>
 <20943.61307.796422.302951@ipc1.ka-ro>
Message-ID: <1372581944.405527352@f25.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Alexander Shiyan writes:
> > > On Sat, Jun 29, 2013 at 12:40:40PM +0400, Alexander Shiyan wrote:
> > > > This patch rework mxc_rtc driver.
> > > > Major changes have been made:
> > > > - Added second clock support (optional) which permit module functionality.
> > > > - Implemented support for periodic interrupts.
> > > > - Some code have been optimized.
> > > > 
> > > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
...
> > > > +	pdata->rtc_ops.open		= mxc_rtc_open;
> > > > +	pdata->rtc_ops.release		= mxc_rtc_release;
> > > > +	pdata->rtc_ops.read_time	= mxc_rtc_read_time;
> > > > +	pdata->rtc_ops.set_mmss		= mxc_rtc_set_mmss;
> > > > +	pdata->rtc_ops.read_alarm	= mxc_rtc_read_alarm;
> > > > +	pdata->rtc_ops.set_alarm	= mxc_rtc_set_alarm;
> > > > +	pdata->rtc_ops.alarm_irq_enable	= mxc_rtc_alarm_irq_enable;
> > > 
> > > So struct rtc_class_ops is embedded into struct rtc_plat_data now. Why
> > > is this necessary?
> > 
> > Just save BSS. Can be moved into cleanup part.
> > 
> The purpose of platform_data is to convey platform specific
> information to drivers, not a general driver local storage.
> Thus platform_data should be treated read-only by drivers.

"pdata" here is not a platform_data.
This is a private driver struct. this was be renamed by me in v1, but I revert
these changes.

---
