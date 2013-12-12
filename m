From: roger.pau@citrix.com (=?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=)
Date: Thu, 12 Dec 2013 16:11:59 +0100
Subject: [Xen-devel] [PATCH v2] xen/block: Correctly define structures
 in public headers on ARM32 and ARM64
In-Reply-To: <1386857960.11201.57.camel@kazak.uk.xensource.com>
References: <1386085237-8334-1-git-send-email-julien.grall@linaro.org>
 <1386857960.11201.57.camel@kazak.uk.xensource.com>
Message-ID: <52A9D23F.3010005@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/13 15:19, Ian Campbell wrote:
> On Tue, 2013-12-03 at 15:40 +0000, Julien Grall wrote:
>> On ARM (32 bits and 64 bits), the double-word is 8-bytes aligned. This will
>> result on different structure from Xen and Linux repositories.
>>
>> As Linux is using __packed__ attribute, it must have a 4-bytes padding before
>> each "id" field.
>>
>> This change breaks guest block support with older kernel. IMHO, it's acceptable
>> because Xen on ARM is still on Tech Preview and the hypercall ABI is not yet
>> freezed.
>>
>> Only one architecture (x86_32) doesn't have 64-bit ABI for the block interface.
>> Don't add padding if Linux is compiled for this architecture.
> 
> Konrad asked for confirmation that this didn't change x86.

I've also tested this using various combinations of kernels, and it
seems to be perfectly fine, so:

Acked-by: Roger Pau Monn? <roger.pau@citrix.com>
