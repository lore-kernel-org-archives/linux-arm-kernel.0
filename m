From: mohan_gg@yahoo.com (Mohan G)
Date: Mon, 20 Apr 2015 05:45:45 +0000 (UTC)
Subject: kvm vs host (arm64)
Message-ID: <1967946020.115308.1429508745411.JavaMail.yahoo@mail.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 
I have got hold of few mustang boards (cortex-a57). Ran a few bench marks to measure perf numbers b/w host and guest (kvm). The numbers 
are pretty bad. (drop of about 90% to that of host). I even tried running this simple program . 

main(){ 
int i=0; 

for(i=0;i<10;i++); 
} 
Profiling the above shows that same kernel functions in guest takes almost 10x to that of host. 
sample below 

Host 
==== 
7202              one-3920  [003] 20015.611563: funcgraph_entry:                   |              find_vma() { 
7203              one-3920  [003] 20015.611564: funcgraph_entry:        0.180 us   |                vmacache_find(); 
7204              one-3920  [003] 20015.611565: funcgraph_entry:        0.120 us   |                vmacache_update(); 
7205              one-3920  [003] 20015.611566: funcgraph_exit:         2.320 us   |              } 


Guest 
===== 

one-751   [000]   206.843300: funcgraph_entry:                   |              find_vma() { 
one-751   [000]   206.843312: funcgraph_entry:        4.880 us   |                vmacache_find(); 
one-751   [000]   206.843335: funcgraph_entry:        2.656 us   |                vmacache_update(); 
one-751   [000]   206.843354: funcgraph_exit:       + 46.256 us  |              } 


kernel: 3.18.9 

Any help ? Note: we were planning to use KVM guest for production purpose. Let me know. 

Regards 
Mohan
