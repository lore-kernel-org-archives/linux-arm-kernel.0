From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 26 Apr 2017 06:14:21 -0700
Subject: [PATCH v5 02/22] KVM: arm/arm64: Add GICV3 pending table save
 API documentation
In-Reply-To: <CAFEAcA8t0Y-UBu_Fx_YTsmnw8zvd4fctTfobdb-akjdx_81PWA@mail.gmail.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-3-git-send-email-eric.auger@redhat.com>
 <CAFEAcA_0N9Jx5ym+=jjmxAzSaXPjt-m+gW1cq90of8Qhw3LOzg@mail.gmail.com>
 <a5ab9181-8398-f62b-12f1-032961b12c28@redhat.com>
 <CAFEAcA-u-sH+v-Pnr_3gRC3iSJP0ZK68+GqkDzmi3xe1-B2WAQ@mail.gmail.com>
 <20170426084830.GB2098@work-vm>
 <4dc866a0-582c-af69-916f-eb435988b5ec@redhat.com>
 <20170426130020.GM4104@cbox>
 <CAFEAcA8t0Y-UBu_Fx_YTsmnw8zvd4fctTfobdb-akjdx_81PWA@mail.gmail.com>
Message-ID: <20170426131421.GA50776@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 02:01:55PM +0100, Peter Maydell wrote:
> On 26 April 2017 at 14:00, Christoffer Dall <cdall@linaro.org> wrote:
> > Alternatively we should mark a pending error notification to the guest
> > in KVM, so that when the guest boots it gets something like an SError
> > instead, given that presumably the guest wrote the weird value.  Except
> > of course if the problem is caused by QEMU fudging with the register
> > value for the PENDBASER.
> 
> If we have scope for complaining at the guest we should do it at
> the point where the guest sets PENDBASER in the first place...
> 

Is that what the hardware would have done?

Also, userspace could restore a bogus value in the PENDBASER (even
though the guest wrote something sane), so maybe we should just keep
this as is and handle it nicely in QEMU?

Thanks,
-Christoffer

> thanks
> -- PMM
