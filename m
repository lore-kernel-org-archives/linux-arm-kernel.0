From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 7 Dec 2016 18:57:14 +0900
Subject: [Nouveau] 4.9-rc7 nouveau fails on arm64 64k page kernel but
 works with 4k
In-Reply-To: <d196c0c8-f429-4275-6246-a4e817b4bdf9@daenzer.net>
References: <042c54f3-e52b-6658-18c7-9c19492485a4@arm.com>
 <CAKb7Uvhewyhnrnd=fw9QrdEDLecG_VMZ8Wfuh-LyCgeW6X_wCw@mail.gmail.com>
 <CAKb7UvgZLafVmC3N0R-dfm4FDtCxUO3fC-4zLwsKauAj=hx=tw@mail.gmail.com>
 <CAKb7UvgW331K53x3wub5o+6LOqeLN5PqgiiJG6WXi+WJDVDzDg@mail.gmail.com>
 <CAAVeFuJc5y8M4Koj-Ge0XpK3PXVS-fnjrpUyD13skeBM1y_K1w@mail.gmail.com>
 <d196c0c8-f429-4275-6246-a4e817b4bdf9@daenzer.net>
Message-ID: <CAAVeFuKfo3sZL84wTiR6ur=PVsPhcaU62ggTwy9r1aQEOq2HZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 7, 2016 at 6:53 PM, Michel D?nzer <michel@daenzer.net> wrote:
> On 07/12/16 06:39 PM, Alexandre Courbot wrote:
>> On Fri, Dec 2, 2016 at 12:23 PM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>>> That's right -- nouveau currently requires 4k page sizes to work. This is a
>>> software limitation, not a hardware one though.
>>
>> Looking at the trace I wonder - is the limitation in Nouveau or in TTM?
>
> Nouveau. Non-4K page sizes work fine with radeon (and presumably amdgpu).

Thanks for the precision. I will check if Tegra iGPUs are also
affected by this - if they are then it gives me a good excuse to take
care of this bug.
