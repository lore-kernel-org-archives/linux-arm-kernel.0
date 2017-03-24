From: panand@redhat.com (Pratyush Anand)
Date: Fri, 24 Mar 2017 22:11:10 +0530
Subject: Query: ARM64: A random failure with hugetlbfs linked mmap() of a
 stack area
In-Reply-To: <20170324161558.GA10491@leverpostej>
References: <4e776e1f-dd11-2fa2-5109-6c2b5184b70d@redhat.com>
 <20170324161558.GA10491@leverpostej>
Message-ID: <d6ee1a17-4518-5a37-f8b7-b62030c24cc7@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Friday 24 March 2017 09:45 PM, Mark Rutland wrote:
> It's clear from the log that the test is simply blatting a number of
> important mappings including libc, so I think this is simply a broken
> test.

Thanks a lot for taking out time and investigating it so quickly. Yes, I 
noticed that as well. Frankly, I do not understand that why that 
upstream libhugetlbfs test is like that. But that test has been passing 
on different architecture for quite long time.

Moreover, even if mmap() in test routine crosses over many other 
text/rd/rw area mappings, should it fail? We are not writing anything to 
mmaped area. So, why should just a creation of another map result in 
segmentation fault?

~Pratyush
