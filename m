From: s-anna@ti.com (Suman Anna)
Date: Mon, 14 Jul 2014 10:58:04 -0500
Subject: [PATCHv2 0/5] OMAP Mailbox framework adoption & DT support
In-Reply-To: <CAPdLdq=ZnPBQiGVbKOk8G5soP=uPYpT7mEjigpR=W1Hc4btV3g@mail.gmail.com>
References: <1405116252-53612-1-git-send-email-s-anna@ti.com>
 <CAPdLdq=ZnPBQiGVbKOk8G5soP=uPYpT7mEjigpR=W1Hc4btV3g@mail.gmail.com>
Message-ID: <53C3FE0C.4080502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On 07/11/2014 06:15 PM, Markus Mayer wrote:
> On 11 July 2014 15:04, Suman Anna <s-anna@ti.com> wrote:
>> Hi,
>>
>> This is a refresh of the OMAP Mailbox framework adoption & DT support
>> series [1], to work with the revised OMAP mailbox DT/hwmod cleanup
>> series [2].
>>
>> The series has one less patch than the previous series, with the patch
>> "mailbox/omap: add a custom of_xlate function" squashed into the OMAP
>> mailbox framework adaptation patch. The first 3 patches deal with the
>> OMAP DT bindings and parse support like previous series, and the last
>> 2 patches deal with the mailbox framework adaptation. The testing is
>> also done with the updated v8 version of mailbox framework [3] from
>> Jassi Brar, no changes are required for the v7 to v8 update.
>>
>> The AM335 PM suspend series [4] which relies on this series also does
>> not require any changes.
> 
> May I ask what branch this series is based upon? I tried a number of
> branches (3.16-rcX, 3.15, linux-next), and the series won't apply to
> any of them (other than patch 1/5, which does apply fine, but that
> also contains no code).

There are couple of dependent preparatory series. You probably missed
the following in the cover letter.
> The series depends on the OMAP mailbox cleanup series [5] and the
> refreshed OMAP mailbox DT/hwmod cleanup series [2].

As long as you pick the two dependent series, they apply fine on any of
the 3.16-rcs. I have posted all the series based on 3.16-rc2. Here's a
merged branch for your reference (not for pulling though, it has one
additional commit to allow me to test on OMAP2)
https://github.com/sumananna/mailbox/commits/submit/3.16-rc2-omap-mbox-v8-fwk-v2

The last 2 patches in the series also depend on the mailbox framework
patches from Jassi to not throw any build errors if enabled.

regards
Suman
