From: neelx@redhat.com (Daniel Vacek)
Date: Fri, 4 May 2018 20:33:56 +0200
Subject: [PATCH v8 0/6] optimize memblock_next_valid_pfn and
 early_pfn_valid on arm and arm64
In-Reply-To: <23b14717-0f4a-10f2-5118-7cb8445fbdab@oracle.com>
References: <1523431317-30612-1-git-send-email-hejianet@gmail.com>
 <05b0fcf2-7670-101e-d4ab-1f656ff6b02f@gmail.com>
 <CACjP9X8bHmrxmd7ZPcfQq6Eq0Mzwmt0saOR3Ph53gp2n-dcKBQ@mail.gmail.com>
 <23b14717-0f4a-10f2-5118-7cb8445fbdab@oracle.com>
Message-ID: <CACjP9X950MTY9qZ7OkzEaph3U1BL8Vo9sT4jBZ8HTuhHez9JAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2018 at 6:53 PM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>> I'm wondering, ain't simple enabling of config
>> DEFERRED_STRUCT_PAGE_INIT provide even better speed-up? If that is the
>> case then it seems like this series is not needed at all, right?
>> I am not sure why is this config optional. It looks like it could be
>> enabled by default or even unconditionally considering that with
>> commit c9e97a1997fb ("mm: initialize pages on demand during boot") the
>> deferred code is statically disabled after all the pages are
>> initialized.
>
> Hi Daniel,
>
> Currently, deferred struct pages are initialized in parallel only on NUMA machines. I would like to make a change to use all the available CPUs even on a single socket systems, but that is not there yet. So, I believe Jia's performance improvements are still relevant.

Ahaa, I thought it also works on UP or single node systems. I didn't
study the code closely. Sorry about the noise. And thank you, Pavel.
You're right.

--nX

> Thank you,
> Pavel
