From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 Jul 2011 09:27:30 +0100
Subject: [PATCH 1/3] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <20110713075319.GA20884@suse.de>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
	<20110712141339.GB24957@sapphire.tkos.co.il>
	<20110712160857.GA7059@suse.de> <4E1D4635.4040107@linaro.org>
	<20110713075319.GA20884@suse.de>
Message-ID: <4E1D56F2.4000909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/07/11 08:53, Greg KH wrote:
> On Wed, Jul 13, 2011 at 08:16:05AM +0100, Lee Jones wrote:
>> On 12/07/11 17:08, Greg KH wrote:
>>> On Tue, Jul 12, 2011 at 05:13:39PM +0300, Baruch Siach wrote:
>>>> Hi Lee,
>>>>
>>>> On Tue, Jul 12, 2011 at 02:08:08PM +0100, Lee Jones wrote:
>>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>>>> ---
>>>>>  drivers/base/Kconfig    |   10 +++++
>>>>>  drivers/base/Makefile   |    1 +
>>>>>  drivers/base/soc.c      |   98 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  include/linux/sys_soc.h |   45 +++++++++++++++++++++
>>>>>  4 files changed, 154 insertions(+), 0 deletions(-)
>>>>>  create mode 100644 drivers/base/soc.c
>>>>>  create mode 100644 include/linux/sys_soc.h
>>>>
>>>> I guess you should Cc Greg Kroah-Hartman <gregkh@suse.de> on this series.
>>
>> Yes, of course. Thanks Baruch.
>>
>>> Only if the submitter wants it applied, obviously, they don't :)
>>>
>>> Why do we have things like the MAINTAINERS file and
>>> scripts/get_maintainer.pl if no one uses them...
>>
>> Doh! Sorry Greg. I'm playing around with my new send-patches.sh and I've
>> neglected to add functionality to apply bespoke To, CC and BCC fields on
>> sending. I'll make the amendments to the script for next time.
> 
> Do you really need another 'send-patches.sh' type script?  What's wrong
> with the built in ones from git or quilt that requires a custom one?

Yes, I really am that lazy. :)

Firstly, I don't send enough patches upstream to enable me to learn then
retain the knowledge to quickly type out a `git send-email` command. If
I write a script just once and keep it centrally located, it will
inevitably save me time in the long-term. Also, when I draft patches I
may do so from a different email address depending on the hat I'm
wearing at any given moment. Supplying an account flag "--can" or
"--lin" is somewhat easier than typing out different credentials each
time. "--smtp-server", "--smtp-server-port", "--smtp-encryption",
"--smtp-user", "--smtp-pass" and "--from" all differ from account to
account.

With this script I dump the patch-set into a directory and issue
"send-patches.sh --lin --arm <patchdir>" and off goes the patch-set to
the Arm ML. However, as Baruch and yourself kindly noticed, I omitted
functionality to add the maintainer and interested party email address -
I'll fix that now.

Sorry for any inconvenience this may have caused.

Kind regards,
Lee
