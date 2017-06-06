From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 6 Jun 2017 18:36:21 +0100
Subject: [PATCH v2 13/25] KVM: arm64: vgic-v3: Add ICV_BPR0_EL1 handler
In-Reply-To: <20170606172348.GJ9464@cbox>
References: <20170601102117.17750-1-marc.zyngier@arm.com>
 <20170601102117.17750-14-marc.zyngier@arm.com>
 <20170606121150.GO9464@cbox> <7bfbee5d-f765-4fa2-02f0-c76a607658dd@arm.com>
 <20170606154609.GI9464@cbox>
 <CAFEAcA9ZHZTJodXstB2YJRnM8QjZtehUwGwAnKKKceMfpB7=gQ@mail.gmail.com>
 <20170606172348.GJ9464@cbox>
Message-ID: <CAFEAcA8ZXvEyBJfJSWG7tUc+heNxreZUmF=dgbt6PTvKHYJ=Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 June 2017 at 18:23, Christoffer Dall <cdall@linaro.org> wrote:
> On Tue, Jun 06, 2017 at 04:56:27PM +0100, Peter Maydell wrote:
>> This depends whether you're talking about the ICC/ICV BPR0/BPR1 registers,
>> or the fields in the ICH_VMCR*. For the former, if CBPR is set then
>> BPR1 reads and writes affect BPR0.
>
> From the spec on ICV_BPR1_EL1: "Non-secure EL1 writes are ignored".
> Doesn't that mean that reads of BPR1 reflect BPR0 but writes are
> ignored?

Yes, you're right.

thanks
-- PMM
