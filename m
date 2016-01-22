From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 22 Jan 2016 10:29:13 -0700
Subject: [RESEND PATCH 0/2] Remove the mistakes detected by the check
 tools.
In-Reply-To: <CAL=D6xaMAG04tnx_WCbTkcGpyAVBVnz3au1ahDFB72k4DpbKsA@mail.gmail.com>
References: <cover.1453271738.git.eric.long@linaro.org>
 <CANLsYkzqFaPs2XbF0kC_jbG1=Jry2+bZMHMq-m9gUxMkoLAhnA@mail.gmail.com>
 <CAL=D6xaMAG04tnx_WCbTkcGpyAVBVnz3au1ahDFB72k4DpbKsA@mail.gmail.com>
Message-ID: <CANLsYkw28iDcisHjXWKdNXLVzfX3h01eEvvhzVZ2bbTX3bJ+eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2016 at 02:15, Eric Long <eric.long@linaro.org> wrote:
> On 22 January 2016 at 00:56, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>>
>> Please run checkpath.pl on your patches.  Also if the changes are of a
>> different nature, ex. indentation problem and wrong argument to a
>> function, please provide two separate patches.
>>
>
> Hi Mathieu,
>
> I had already ran checkpath.pl, and there was no error and warning.

Using a 4.4 kernel I got the following chackpatch warnings:

mpoirier at t430:~/work/linaro/coresight/kernel-maint$
./scripts/checkpatch.pl
0001-coresight-Remove-the-mistakes-detected-by-sparse-too.patch
0002-coresight-Remove-the-mistakes-detected-by-smatch-too.patch
---------------------------------------------------------------
0001-coresight-Remove-the-mistakes-detected-by-sparse-too.patch
---------------------------------------------------------------
WARNING: A patch subject line should describe the change not the tool
that found it
#4:
Subject: [PATCH 1/2] coresight: Remove the mistakes detected by sparse tool

total: 0 errors, 1 warnings, 32 lines checked

0001-coresight-Remove-the-mistakes-detected-by-sparse-too.patch has
style problems, please review.
---------------------------------------------------------------
0002-coresight-Remove-the-mistakes-detected-by-smatch-too.patch
---------------------------------------------------------------
WARNING: A patch subject line should describe the change not the tool
that found it
#4:
Subject: [PATCH 2/2] coresight: Remove the mistakes detected by smatch tool

total: 0 errors, 1 warnings, 8 lines checked

0002-coresight-Remove-the-mistakes-detected-by-smatch-too.patch has
style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
mpoirier at t430:~/work/linaro/coresight/kernel-maint$ ls


> All the changes are either indentation problems or wrong argument,
> except one static defined problem. So I think there is no need to
> separate the patch.

After fixing the above checkpatch warning bunching changes by tools
won't make sense anymore.

> By the way, the patches I had send were created base on the check
> tools, one for smatch and another for sparse. In case I need to separate
> the patches, do I need to follow the this principle. Thanks.

It's usually one semantic change per patch - the tool that highlighted
the problem is secondary.

>
> Best Regards.
> Eric
