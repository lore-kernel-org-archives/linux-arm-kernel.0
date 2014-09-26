From: pintu.k@outlook.com (Pintu Kumar)
Date: Fri, 26 Sep 2014 14:22:27 +0530
Subject: Changing PAGE_ALLOC_COSTLY_ORDER from 3 to 2
Message-ID: <BAY169-W38291C97E5E42E5DCA8787EFBF0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I wanted to know about the impact of changing PAGE_ALLOC_COSTLY_ORDER value from 3 to 2.
This macro is defined in include/linux/mmzone.h
#define PAGE_ALLOC_COSTLY_ORDER?? 3

As I know this value should never be changed irrespective of the type of the system.
Is it good to change this value for RAM size: 512MB, 256MB or 128MB?
If anybody have changed this value and experience any kind of problem or benefits please let us know.

We noticed that for one of the Android product with 512MB RAM, the PAGE_ALLOC_COSTLY_ORDER was set to 2.
We could not figure out why this value was decreased from 3 to 2.

As per my analysis, I observed that kmalloc fails little early, if we change this value to 2.
This is also visible from the _slowpath_ in page_alloc.c

Apart from this we could not find any other impact.
If anybody is aware of any other impact, please let us know.



Thank you!
Regards,
Pintu Kumar

 		 	   		  
