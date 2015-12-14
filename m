From: dcashman@android.com (Daniel Cashman)
Date: Mon, 14 Dec 2015 12:45:17 -0800
Subject: [PATCH v6 3/4] arm64: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <20151214111949.GD6992@arm.com>
References: <1449856338-30984-1-git-send-email-dcashman@android.com>
 <1449856338-30984-2-git-send-email-dcashman@android.com>
 <1449856338-30984-3-git-send-email-dcashman@android.com>
 <1449856338-30984-4-git-send-email-dcashman@android.com>
 <20151214111949.GD6992@arm.com>
Message-ID: <566F2A5D.6010100@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2015 03:19 AM, Will Deacon wrote:
>> +# max bits determined by the following formula:
>> +#  VA_BITS - PAGE_SHIFT - 3
> 
> Now that we have this comment, I think we can drop the unsupported
> combinations from the list below. That means we just end up with:
> 
>> +config ARCH_MMAP_RND_BITS_MAX
>> +       default 19 if ARM64_VA_BITS=36
>> +       default 24 if ARM64_VA_BITS=39
>> +       default 27 if ARM64_VA_BITS=42
>> +       default 30 if ARM64_VA_BITS=47
>> +       default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
>> +       default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
>> +       default 33 if ARM64_VA_BITS=48

Unless you object, I'd like to keep the last 3 as well, to mirror the
min bits, should any new configurations be added but not reflected here:
+       default 15 if ARM64_64K_PAGES
+       default 17 if ARM64_16K_PAGES
+       default 18

The first two of these three should be changed as well to 14 and 16.

Thanks,
Dan
