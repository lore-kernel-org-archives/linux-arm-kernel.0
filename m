From: liu.song.a23@gmail.com (Song Liu)
Date: Mon, 20 Aug 2018 21:55:38 -0700
Subject: [PATCH v9 0/4] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <b0b9e181-0df7-dc8f-927a-a2cf52bed93d@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
 <b0b9e181-0df7-dc8f-927a-a2cf52bed93d@linux.ibm.com>
Message-ID: <CAPhsuW4SQA+uu9=a2jT+KW0Yq=yCyWqe13KtsB_ATTMiNzCXkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2018 at 9:42 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> Hi Song,
>
>> root at virt-test:~# ~/a.out
>> 11
>> semaphore 0
>> semaphore 0
>> semaphore 2      <<<  when the uprobe is enabled
>
> Yes, this happens when multiple vmas points to the same file portion.
> Can you check /proc/`pgrep a.out`/maps.
>
> Logic is simple. If we are going to patch an instruction, increment the
> reference counter. If we are going to unpatch an instruction, decrement
> the reference counter. In this case, we patched instruction twice and
> thus incremented reference counter twice as well.

Yes, this makes sense.

Song

>
> Ravi
>
