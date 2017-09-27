From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Wed, 27 Sep 2017 13:57:58 +0200
Subject: [PATCH 0/2] ARM: earlycon: Fix <CR><LF><CR> end-of-line
In-Reply-To: <20170927115255.GT20805@n2100.armlinux.org.uk>
References: <20170927114929.9259-1-alexander.sverdlin@nokia.com>
 <20170927115255.GT20805@n2100.armlinux.org.uk>
Message-ID: <d3edd7bb-a787-1850-4e5b-07d2ccdc025c@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/09/17 13:52, Russell King - ARM Linux wrote:
>> Since very beginning the early serial console on ARM produces <CR><LF><CR>
>> line terminator. There are couple of problems connected:
>> 1. C function early_write() adds <CR> to each <LF> even though underlying
>>    Assembler printch() does this already
>> 2. printch() adds <CR> *after* <LF>, not before, as it is usually being done
> You omit to say why you want this change...

Well, only because it produces normal serial log after the change, as all other ARCHs
do. Depending on the viewer one either doesn't have extra "^M" at the beginning of each
line or the lines are not interlaced (with extra empty lines) any more.

-- 
Best regards,
Alexander Sverdlin.
