From: john.garry@huawei.com (John Garry)
Date: Wed, 3 Jan 2018 12:22:16 +0000
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended
 events
In-Reply-To: <20180102174814.GT25156@tassilo.jf.intel.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
 <1512490399-94107-3-git-send-email-john.garry@huawei.com>
 <20171206133607.GA12508@krava>
 <c46d07bc-a6f0-1b01-0595-a615781f8cff@huawei.com>
 <20171208122918.GE2799@krava>
 <afd7bf2a-4d94-0db0-640d-b1c93c8ba230@huawei.com>
 <20171209073104.GB14297@krava>
 <5d322353-2785-a99f-bcd8-b948bd6cb09a@huawei.com>
 <20171216184701.GB25156@tassilo.jf.intel.com>
 <edd01090-755e-fd73-434b-b910272c625a@huawei.com>
 <20180102174814.GT25156@tassilo.jf.intel.com>
Message-ID: <dc3a2808-5c16-fc47-80a3-d12823ff6f2d@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2018 17:48, Andi Kleen wrote:
>> Can you describe how you autogenerate the JSONs? Do you have some internal
>> proprietary HW file format describing events, with files supplied from HW
>> designer, which you can just translate into a JSON? Would the files support
>> deferencing events to improve scalability?
>
> For Intel JSON is an official format, which is maintained for each CPU.
> It is automatically generated from an internal database
> https://download.01.org/perfmon/
>
> I have some python scripts to convert these Intel JSONs into the perf
> format (which has some additional headers, and is split into
> different categories, and add metrics).

OK, understood.

Unfortunately I could not see such a database being maintained for ARM 
implementors.

>
> They have some Intel specifics, so may not be useful for you.
>
> There's no support for dereference, each CPU gets its own unique file.

Right.

>
> But you could do the a merge simply with the attached script which merges
> two JSON files.

I assume that you're talking about simply merging the micro architecture 
and the platform specific event JSONS at build time.

If yes, this would not work for us:
- the microarchitecture JSON would contain definitions of all events, 
but there is no architectural method to check if they are implemented
- we need to deal with scenario of non-standard event implementations

But I could update the script to deal with this and add to the build 
(Jirka looked to be ok with the same in jevents, albeit a few caveats).

All the best,
John

>
> -Andi
>
