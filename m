From: rbairva@gmail.com (rd bairva)
Date: Thu, 7 Jul 2011 14:48:05 +0530
Subject: ARM cortex A9 performance issue
Message-ID: <CAE_nTV4VgcNB0gc64zEPEfHp-hnDBsw6QsM=GqEObXAwzMTzTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We are trying to benchmark ARM cortex A9 dual core behavior with
respect to single core
performance and also measuring it with respect to x86 dual core/single core.
Please find attached with the mail is c app which we are using for benchmarking.

Simple overview of C application:
- It creates a shared memory area using shm_open().
  in this shm area, it declares 2 Process shared pthread mutex, lets say L1, L2.
- then it forks to create a server_task and client task.
- server_task takes L1 lock, touches a shm area, unlock L2, in a loop.
- client_task takes L2 lock, touches a shm area, unlock L1, in a loop.
- This loop runs for N number of times that we measure.

Here are the results for N/sec for different CPUs.

Platform              Up cores              req/sec                cpuload
Cortexa9                    2                              ~44000
            100%
Cortexa9                    1                              ~18000
            100%
X86                            2                              ~64000
               35%
X86                            1                              ~458886
             100%     (1 cpu down by sysfs)

we are not able to understand the results.
- why for coretx A9 both dual/single core we are getting 100% cpu usage.
- why in case of x86, N/sec is very high for single core than dual core.
- why single core N/s is 1/3 in case of CortexA9.

Thanks,
Ramdayal
-------------- next part --------------
A non-text attachment was scrubbed...
Name: shmem-test-20110421.tgz
Type: application/x-gzip
Size: 2648 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110707/6f2e4b29/attachment.tgz>
