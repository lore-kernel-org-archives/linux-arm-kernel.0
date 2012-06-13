From: robherring2@gmail.com (Rob Herring)
Date: Wed, 13 Jun 2012 13:09:36 -0500
Subject: [PATCH v3 0/4] DT clock bindings
In-Reply-To: <20120613152658.GE32111@tbergstrom-lnx.Nvidia.com>
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
 <20120613152658.GE32111@tbergstrom-lnx.Nvidia.com>
Message-ID: <4FD8D760.3070406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,

On 06/13/2012 10:26 AM, Peter De Schrijver wrote:
> On Tue, Jun 12, 2012 at 04:41:47PM +0200, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This series defines clock bindings for Device-Tree and adds kernel
>> support using the common clock infrastructure. The last patch enables
>> DT clock support for the Calxeda Highbank platform.
>>
>> I'm posting this again to solicit further review. There has been some
>> discussion[1], but no definite path forward. This series is not changed
>> from the last post other than rebasing to v3.5-rc2.
>>
>> Rob
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/100932.html
>>
> 
> How would this binding work for clocks which can take a spinlock pointer as a
> init parameter (eg. clk-gate).

Other than fixed clocks, this makes no attempt at generic bindings.
There is still per clock init required which can allocate a spinlock if
necessary. If you look at the highbank code, it would be trivial to
initialize spinlocks as needed.

Rob

> Cheers,
> 
> Peter.
