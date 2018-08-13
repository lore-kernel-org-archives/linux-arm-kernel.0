From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Mon, 13 Aug 2018 19:56:53 +0530
Subject: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180813131723.GC28360@redhat.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
 <20180813115019.GB28360@redhat.com>
 <fa85d19f-b22c-e09c-b8d2-f68f0c79de15@linux.ibm.com>
 <20180813131723.GC28360@redhat.com>
Message-ID: <a532988a-c530-7df8-f059-dd7a4b22abc2@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/13/2018 06:47 PM, Oleg Nesterov wrote:
> On 08/13, Ravi Bangoria wrote:
>>
>>> But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
>>> hook and avoid delayed_uprobe_install() in uprobe_mmap().
>>
>> I'm sorry. I didn't get this.
> 
> Sorry for confusion...
> 
> I meant, if only exec*( could race with _register(), we could add another uprobe
> hook which updates all (delayed) counters before return to user-mode.

Ok.

> 
>>> Afaics, the really problematic case is dlopen() which can race with _register()
>>> too, right?
>>
>> dlopen() should internally use mmap() right? So what is the problem here? Can
>> you please elaborate.
> 
> What I tried to say is that we can't avoid uprobe_mmap()->delayed_uprobe_install()
> because dlopen() can race with _register() too, just like exec.

Right :)

Thanks,
Ravi
