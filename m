From: maz@misterjones.org (Marc Zyngier)
Date: Wed, 14 Aug 2013 16:57:00 +0100
Subject: [PATCH] ARM64: KVM: Fix =?UTF-8?Q?coherent=5Ficache=5Fguest?=
 =?UTF-8?Q?=5Fpage=28=29=20for=20host=20with=20external=20L=33-cache=2E?=
In-Reply-To: <CAFEAcA_Sexa36nq8r2YsuPptcKFcKytfwGEYi+xm-DO+3j1iSw@mail.gmail.com>
References: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
 <f8917fe8409b1fae634c7de45e34d4a7@www.loen.fr>
 <CAAhSdy2TctgKk7m48S7jUCMr2dkDoeyT-r=-SMX+_Ce-sUimYA@mail.gmail.com>
 <38A6DD0E-5639-43BB-8318-32D59923E309@suse.de>
 <19553bad1c8427526f6e9a87d605ade3@www.loen.fr>
 <CAFEAcA_Sexa36nq8r2YsuPptcKFcKytfwGEYi+xm-DO+3j1iSw@mail.gmail.com>
Message-ID: <394887c7adffc3a3df0733329a9b5fb3@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-08-14 16:41, Peter Maydell wrote:
> On 14 August 2013 16:34, Marc Zyngier <maz@misterjones.org> wrote:
>> When userspace loads the kernel into memory, the kernel is not 
>> flushed
>> to RAM, and may sit in the L3 cache if the cache is big enough. You
>> end-up executing garbage... My proposed fix is to let kvmtool do the
>> flushing, as we have userspace cache management operations for this
>> exact purpose.
>
> Why does this issue only apply to the loaded kernel and not to
> the zero bytes in the rest of RAM? I know executing zeroes
> isn't a very useful thing to do but it should be a well defined
> thing.

Good point, and not quite sure just yet. Probably we get a zeroed, 
clean page?

Anup, can you elaborate on how your L3 cache behaves?

Thanks,

         M.
-- 
Who you jivin' with that Cosmik Debris?
