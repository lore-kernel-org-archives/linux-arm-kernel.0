From: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 25 May 2012 10:13:50 -0700
Subject: [PATCH] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <4FBFBBF3.3090204@hp.com>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
 <20120525113432.3beea6ed@tukaani.org> <4FBFB3F3.1000606@hp.com>
 <4FBFBBF3.3090204@hp.com>
Message-ID: <4FBFBDCE.6030104@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2012 10:05 AM, Thavatchai Makphaibulcboke wrote:
>> We could do that.  But according to the comment in the original
>> implementation, there seems to be a concern regarding its performance
>> speed. If you believe all archs' memcpy would give comparable
>> performance to the memmove. then I could do that.
>>
> 
> Also how about the case for overlapping buffer, especially when the
> destination is at a higher address?  I do not believe memcpy guarantee
> to work.

memcpy() is not guaranteed to work for any overlap; that is what
memmove() is for.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
