From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 28 Mar 2017 12:33:59 +0100
Subject: [PATCH] kvm: pass the virtual SEI syndrome to guest OS
In-Reply-To: <20170328112328.GA31156@cbox>
References: <1489996534-8270-1-git-send-email-gengdongjiu@huawei.com>
 <7055772d-2a20-6e0c-2bf8-204bc9ef52a5@arm.com>
 <b912c293-4314-7c90-30a4-2f986feb1670@huawei.com>
 <22fb583f-a33e-15f8-a059-fb112b27dd4f@arm.com> <58CFF058.8020205@arm.com>
 <76795e20-2f20-1e54-cfa5-7444f28b18ee@huawei.com>
 <20170321113428.GC15920@cbox>
 <58D17AF0.2010802@arm.com> <20170321193933.GB31111@cbox>
 <58DA3F68.6090901@arm.com> <20170328112328.GA31156@cbox>
Message-ID: <CAFEAcA9O_mUbO=RChLwpj=qr0ZDg6iEsYwzWLTbHMRV-9z-1vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 March 2017 at 12:23, Christoffer Dall <cdall@linaro.org> wrote:
> On Tue, Mar 28, 2017 at 11:48:08AM +0100, James Morse wrote:
>> On the host, part of UEFI is involved to generate the CPER records.
>> In a guest?, I don't know.
>> Qemu could generate the records, or drive some other component to do it.
>
> I think I am beginning to understand this a bit.  Since the guet UEFI
> instance is specifically built for the machine it runs on, QEMU's virt
> machine in this case, they could simply agree (by some contract) to
> place the records at some specific location in memory, and if the guest
> kernel asks its guest UEFI for that location, things should just work by
> having logic in QEMU to process error reports and populate guest memory.

Is "write direct to guest memory" the best ABI here or would
it be preferable to use the fw_cfg interface for the guest UEFI
to retrieve the data items on demand?

Is there a pre-existing "this is how it works on x86" implementation?

thanks
-- PMM
