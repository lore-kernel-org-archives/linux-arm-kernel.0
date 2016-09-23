From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 23 Sep 2016 17:57:23 +0100
Subject: [PATCH] ARM/dt: Respect #address-cells when parsing CPUs
In-Reply-To: <31c4684aa8ef7ef210cc74da5f1b02ff2882a099.1474645829.git.robin.murphy@arm.com>
References: <31c4684aa8ef7ef210cc74da5f1b02ff2882a099.1474645829.git.robin.murphy@arm.com>
Message-ID: <a42764a5-c7a2-8877-6a3c-bb50c913b25d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/09/16 16:51, Robin Murphy wrote:
> Whilst MPIDR values themselves are only 32 bits, it is still perfectly
> valid for a DT to have #address-cells > 1 in the CPUs node, resulting in
> the "reg" property having leading zero cell(s). In that situation, the
> big-endian nature of the data conspires with the current behaviour of
> just parsing the first cell to cause the kernel to think all CPUs have
> ID 0, and become resoundingly unhappy as a consequence.
>
> Take #address-cells into account when parsing CPUs so as to be correct
> under any circumstances.
>

Lorenzo had a patch [1] to address this a while ago. I assume all the
other patches in the series have been merged hopefully which fixes the 
device trees.

-- 
Regards,
Sudeep

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/169093.html
[2] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/169083.html
