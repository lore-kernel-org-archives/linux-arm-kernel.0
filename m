From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu, 02 Aug 2012 21:08:19 +0200
Subject: doubts about switch_mm
Message-ID: <501AD023.3020204@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, 

I know that switch_mm has been like this for years, and that it seems 
to work, but still, something seems wrong:

switch_mm code, as of 3.5 contains:

1        if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {  
2                check_and_switch_context(next, tsk);                             
3                if (cache_is_vivt())                                             
4                        cpumask_clear_cpu(cpu, mm_cpumask(prev));                
5        }                                                                        

Line 1 seems to mean that maybe switch_mm is called with prev == next.
But then, what line 4 does is certainly wrong if prev == next.

Regards.

-- 
                                                                Gilles.
