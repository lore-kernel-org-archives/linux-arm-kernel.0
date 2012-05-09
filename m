From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Wed, 9 May 2012 18:48:31 -0500
Subject: [PATCH 0/2] OMAP: mailbox initial device tree support
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EA68F6D@DBDE01.ent.ti.com>
References: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
 <B5906170F1614E41A8A28DE3B8D121433EA68F6D@DBDE01.ent.ti.com>
Message-ID: <CALLhW=5u75kSU1gorxMga2XHp4fbZnBBJhicTKGUCSTH86nAww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaibhav,

Somehow I missed this mail.

On 2 May 2012 00:42, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> Hi Omar,
>
> On Tue, May 01, 2012 at 23:17:38, Omar Ramirez Luna wrote:
>> To allow mailbox driver to function with device tree.
>>
>> Tested in OMAP4 and OMAP3. OMAP2 untested.
>>
>
> I think the mailbox code needs a cleanup similar to what you
> had proposed earlier [1] before the device tree support is added.

I believe the cleanup needs to be there, but this is generic enough to
support DT as it is.

> We probably need to decide whether the number of mailbox sub-modules
> should be part of hwmod attribute or come from device tree.

All the data is currently coming from hwmod, so I don't see why this
must be split now between hwmod and DT, but I'm open for suggestions.

> IMO the
> static allocation of the mailboxes is better suited in the device-tree
> data.

If possible I wouldn't want to tie use case specifics to DT or hwmod,
the whole point for the cleanup was to allow a dynamic mailbox
allocation and not statically assign them.

Regards,

Omar
