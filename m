From: liu.song.a23@gmail.com (Song Liu)
Date: Mon, 13 Aug 2018 09:27:36 -0700
Subject: [PATCH v8 5/6] trace_uprobe/sdt: Prevent multiple reference
 counter for same uprobe
In-Reply-To: <20180813084922.GB44470@linux.vnet.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-6-ravi.bangoria@linux.ibm.com>
 <CAPhsuW5g1dOnceA=kqfpC+rR6EguJaR+wPwY9nSWLbGSSj5XjQ@mail.gmail.com>
 <66f84261-aa3e-4692-a124-09537fda4312@linux.ibm.com>
 <20180813084922.GB44470@linux.vnet.ibm.com>
Message-ID: <CAPhsuW4Vo0Py9EmiAx64v1ExwH49NuPaXYWr9Hmm6mLFewbHog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2018 at 1:49 AM, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
> * Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-08-13 13:49:44]:
>
>> Hi Song,
>>
>> On 08/11/2018 01:42 PM, Song Liu wrote:
>> > Do we really need this given we already have PATCH 4/6?
>> > uprobe_regsiter() can be called
>> > out of trace_uprobe, this patch won't catch all conflicts anyway.
>>
>> Right but it, at least, catch all conflicts happening via trace_uprobe.
>>
>> I don't mind in removing this patch but I would like to get an opinion of
>> Oleg/Srikar/Steven/Masami.
>>
>
> I would suggest to keep it, atleast it can ctah conflicts happening via
> trace_uprobe.
>

Yeah, that makes sense.

Reviewed-by: Song Liu <songliubraving@fb.com>
