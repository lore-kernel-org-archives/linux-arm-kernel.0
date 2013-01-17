From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 17 Jan 2013 10:55:14 +0100
Subject: [[PATCH v2]] OMAP: omap4-panda: add WiLink shared transport power
 functions
In-Reply-To: <20130117093417.GH10814@arwen.pp.htv.fi>
References: <1358372702-13102-1-git-send-email-coelho@ti.com>
 <50F7C4A7.5060202@ti.com> <20130117093417.GH10814@arwen.pp.htv.fi>
Message-ID: <50F7CA82.4050509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 10:34 AM, Felipe Balbi wrote:
>> I just wonder how this is going to work with DT... You are not going to have
>> the ability to use callback in this form.
>> I think the GPIO handling should be done in the driver itself rather than in
>> the board file.
> 
> that can (should ?) be moved to ti-st eventually. In fact I don't know
> why it was removed in the first place, we would need Pavan to help us
> with that query.

Yes, this is a good question. I don't know what is the spacial thing platforms
need to do in the callback..

> Still, for -rc, the minimal patch had to be cooked, right ?

Sure it need to be fixed. I would try to revert the patch which caused the
issue (eccf2979 drivers/misc/ti-st: remove gpio handling).

Should fix the legacy boot, but it is going to be even bigger fun to move to
DT (and get rid of the callbacks).

I don't have anything against this patch as such. Just wanted to point out the
obvious that the comfort of callbacks are not going to be around in some cases.

-- 
P?ter
