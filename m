From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Oct 2014 12:14:26 -0300
Subject: [PATCH 3/7] irqchip: armada-370-xp: Introduce a is_percpu_irq()
 helper for readability
In-Reply-To: <20141022135813.GK22642@leverpostej>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022135813.GK22642@leverpostej>
Message-ID: <5447C9D2.1090206@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2014 10:58 AM, Mark Rutland wrote:
> Hi,
> 
> On Wed, Oct 22, 2014 at 02:43:43PM +0100, Ezequiel Garcia wrote:
>> This commit introduces a helper function is_percpu_irq(), to be used
>> when interrupts are mapped to decide which ones are set as per CPU.
>>
>> This change will allow to extend the list of per cpu interrupts in a less
>> intrusive fashion; also, it makes the code slightly more readable by keeping
>> a list of the per CPU interrupts.
> 
> I believe you can use the existing (and similarly named) irq_is_percpu
> for this.

No, that won't work. The irq_is_percup will work only after you set the
interrupt as per CPU, which is precisely the purpose of
armada_370_xp_mpic_irq_map.

At some point, you need to decide tell the kernel which interrupts are
per CPU, so we put that choice in an internal helper.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
