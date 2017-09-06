From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 6 Sep 2017 18:35:52 +0800
Subject: [PATCH] arm64: KVM: VHE: save and restore some PSTATE bits
In-Reply-To: <981d7334-8841-d3e3-0833-1aa061bf97a2@arm.com>
References: <0184EA26B2509940AA629AE1405DD7F2015DF717@DGGEMA503-MBX.china.huawei.com>
 <2a5d4299-2523-aef5-7db1-f351ca66b562@arm.com>
 <e47a9304-b429-b2bd-f151-d65f1c32044c@huawei.com>
 <981d7334-8841-d3e3-0833-1aa061bf97a2@arm.com>
Message-ID: <62860a85-c29c-87bb-24b7-c6e5ac6065f9@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vladimir,

On 2017/9/6 17:41, Vladimir Murzin wrote:
> Can you please elaborate on cases where PAN is not enabled?

I mean the informal private usage, For example, he disabled the PAN dynamically to let kernel space to access the user space.
After he dynamic disabled the PAN, then switched to guest OS. after return to host. he found the PAN stage is modified.
Of cause this is not a formal usage, in our host kernel, it is always enabled, no dynamic change, but I means it may exist such cases.
