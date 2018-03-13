From: dyoung@redhat.com (Dave Young)
Date: Tue, 13 Mar 2018 09:54:58 +0800
Subject: [Query] ARM64 kaslr support - randomness, seeding and kdump
In-Reply-To: <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
Message-ID: <20180313015458.GA4352@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/18 at 08:58pm, Ard Biesheuvel wrote:
[snip]
> > - We pass the dtb over to the kdump kernel for arm64 kdump, but the
> > '/chosen/kaslr-seed' property would be zeroed out already by the
> > primary kernel and the secondary would work in a *nokaslr* environment
> > due to the same (see [4] for example)
> >
> 
> What would be the point of randomizing the placement of the kdump
> kernel? And don't say 'because x86 does it', because that is not a
> good reason.

Kdump kernel does not need kaslr. Actually in Fedora we use 'nokaslr'
even for x86_64

Thanks
Dave
