From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Mon, 25 Aug 2014 17:25:18 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <53FB3E7F.4000503@redhat.com>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com> <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com> <53FB3E7F.4000503@redhat.com>
Message-ID: <53FB555E.5040409@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 25.08.2014 15:47, schrieb Hans de Goede:
> On 08/25/2014 03:39 PM, Thierry Reding wrote:
>> On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
>>> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
>>>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
>>>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
>>>>>> If not, perhaps the clock driver should force the clock to be
>>>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
[...]
> As for the suggestion to simply never disable the plls / ahb gates by blocking
> them from ever being disabled in the sunxi clock driver, that is not really
> a solution either, as we want to be able to turn these things off to safe
> power on screen blank once control has been turned over to the kms driver.

Without wanting to take sides on the simplefb matter, can't you just use
clk_ignore_unused in bootargs to work around the issue at hand?
That's what I do on the Spring Chromebook.

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
