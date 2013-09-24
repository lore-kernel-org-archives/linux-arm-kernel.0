From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Tue, 24 Sep 2013 11:43:53 +0200
Subject: [PATCH v5 1/4] media: s5p-tv: Replace mxr_ macro by default dev_
In-Reply-To: <13162989.WhfDRzW6dg@amdc1032>
References: <1379775649-6331-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1379775649-6331-2-git-send-email-m.krawczuk@partner.samsung.com>
 <52405519.3020504@samsung.com> <13162989.WhfDRzW6dg@amdc1032>
Message-ID: <52415ED9.3030407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/23/2013 05:48 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Tomasz,
> 
> On Monday, September 23, 2013 04:50:01 PM Tomasz Stanislawski wrote:
>> Hello,
>> May I ask what is the rationale for this patch?
>> To reduce a few lines of code?
> 
> This patch makes source code more generic-like and easier to follow (mxd_r*

more generic(-like?) - NOT. Using mxr_ macros is a more generic way to produce logs
because one can change only one line to change error format for the whole module.
For example, in case of mxr_ family, a patch adding function name to debug message
would require just a few lines patch. Using in case of dev_ family, one has to
produce 200-lines of highly conflicting patch.

'easier to follow' - MAYBE. I agree that some people may prefer to
see more directly what is happening, but tell me if you really consider line:

mxr_dbg(mdev, "this is debug\n");

as a very confusing and obfuscated piece of code.

COME ON!

Regards,
TS

> macros currently only obfuscate the code and make them harder to read for
> everybody, maybe besides the original driver author ;). Removal of few
> superfluous lines of code is just a bonus.
> 
>> Or to give up possibility of changing message format in just one place?
> 
> For over two and half year (since s5p-tv driver introduction in Feb 2011)
> such change was not needed and it doesn't seem that keeping the code to
> allow such possibility is worth an added code obfuscation.
> 
> Besides you can easily script a change to message format so in practice
> I don't see a real advantage of keeping non-standard messaging macros
> just for easing a potential message format conversion.
> 
>> I could see migrating from mxr_* to pr_* could seen as the fix, but not this.
> 
> Such migration seems to be pointless as you would have to add an extra
> argument to pr_* to not lose the device information.

There is something called pr_fmt. It may help with mentioned issue.

> 



> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
>> Waiting for reply,
>> Tomasz Stanislawski
>>
>>
>> On 09/21/2013 05:00 PM, Mateusz Krawczuk wrote:
>>> Replace mxr_dbg, mxr_info and mxr_warn by generic solution.
>>>
>>> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> ---
>>>  drivers/media/platform/s5p-tv/mixer.h           |  12 ---
>>>  drivers/media/platform/s5p-tv/mixer_drv.c       |  47 ++++++-----
>>>  drivers/media/platform/s5p-tv/mixer_grp_layer.c |   2 +-
>>>  drivers/media/platform/s5p-tv/mixer_reg.c       |   6 +-
>>>  drivers/media/platform/s5p-tv/mixer_video.c     | 100 ++++++++++++------------
>>>  drivers/media/platform/s5p-tv/mixer_vp_layer.c  |   2 +-
>>>  6 files changed, 78 insertions(+), 91 deletions(-)
>>>
