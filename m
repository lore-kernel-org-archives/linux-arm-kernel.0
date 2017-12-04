From: rafael@kernel.org (Rafael J. Wysocki)
Date: Mon, 4 Dec 2017 15:05:05 +0100
Subject: [PATCH v2 2/5] mm: memory_hotplug: Remove assumption on memory
 state before hotremove
In-Reply-To: <20171204112855.GA6373@samekh>
References: <cover.1511433386.git.ar@linux.vnet.ibm.com>
 <4e21a27570f665793debf167c8567c6752116d0a.1511433386.git.ar@linux.vnet.ibm.com>
 <20171129004913.GB1469@linux-l9pv.suse>
 <20171129015229.GD1469@linux-l9pv.suse>
 <20171204112855.GA6373@samekh>
Message-ID: <CAJZ5v0hZPtKvBBr3mRhpE5zbWVYYL6To8CWrf_drwWXQ=ohRjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 4, 2017 at 12:28 PM, Andrea Reale <ar@linux.vnet.ibm.com> wrote:
> Hi Joey,
>
> and thanks for your comments. Response inline:
>

[cut]

>>
>> So, the BUG() is useful to capture state issue in memory subsystem. But, I
>> understood your concern about the two steps offline/remove from userland.
>>
>> Maybe we should move the BUG() to somewhere but not just remove it. Or if
>> we think that the BUG() is too intense, at least we should print out a error
>> message, and ACPI should checks the return value from subsystem to
>> interrupt memory-hotplug process.
>
> In this patchset, BUG() is moved to acpi_memory_remove_memory(),
> the caller of arch_remove_memory(). However, I agree with Michal, that
> we should not BUG() here but rather halt the hotremove process and print
> some errors.
> Is there any state in ACPI that should be undone in case of hotremove
> errors or we can just stop the process "halfway"?

I have to recall a couple of things before answering this question, so
that may take some time.

Thanks,
Rafael
