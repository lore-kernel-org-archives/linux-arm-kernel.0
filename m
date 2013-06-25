From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 25 Jun 2013 19:19:02 +0800
Subject: [Question] race between spin_lock and spin_unlock
In-Reply-To: <20130625105923.GE31838@mudshark.cambridge.arm.com>
References: <CACVXFVMBL5E5SGwDatn_ay0sPOhqPKTwouCbzjwrhPuRKHNDcg@mail.gmail.com>
 <20130624154357.GB25582@mudshark.cambridge.arm.com>
 <CACVXFVNgONa79n+7Bg4p4Fx568XaK6gy+L9tCrP=CmOGwKY7ig@mail.gmail.com>
 <20130624163732.GC25582@mudshark.cambridge.arm.com>
 <CACVXFVMW39SD2YvW-+_A_kv0YgyOToB7xqhHgT7eZKxxWL0-mA@mail.gmail.com>
 <20130625084805.GB31006@mudshark.cambridge.arm.com>
 <CACVXFVNq111U5OvVNXX-xm8RodQoXSjLUSFHzehRvtdk9jMCzA@mail.gmail.com>
 <20130625105923.GE31838@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVMGMUFJztaaypAQnDKxCc=invjzxXuebGyVtoaMsxGz0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 6:59 PM, Will Deacon <will.deacon@arm.com> wrote:
>
> There's no problem, because spin_unlock(&B) in the interrupt handler on CPU0
> (which must happen before it returns from the interrupt) will send a further
> event and the wfe encountered when resuming spin_lock(&A) will not wait.

Got it, thanks for your explanation.


Thanks,
-- 
Ming Lei
