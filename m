From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 27 Feb 2018 16:39:19 -0800
Subject: [PATCH] ARM: dts: NSP: Fix amount of RAM on BCM958625HR
In-Reply-To: <CAC3K-4rqYMUBtbwaojWBF-0biEV-WSPpe=0bDocL4TUrrL4gGQ@mail.gmail.com>
References: <20180227010312.7495-1-f.fainelli@gmail.com>
 <CAC3K-4rqYMUBtbwaojWBF-0biEV-WSPpe=0bDocL4TUrrL4gGQ@mail.gmail.com>
Message-ID: <cf9e6bc5-094a-e658-cdd6-6495fbe99da6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2018 07:02 AM, Jon Mason wrote:
> On Mon, Feb 26, 2018 at 8:03 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> Jon attempted to fix the amount of RAM on the BCM958625HR in commit
>> c53beb47f621 ("ARM: dts: NSP: Correct RAM amount for BCM958625HR board")
>> but it seems like we tripped over some poorly documented schematics.
>>
>> The top-level page of the schematics says the board has 2GB, but when
>> you end-up scrolling to page 6, you see two chips of 4GiB (512MB) but
>> what the bootloader really initializes only 512MB, any attempt to use
>> more than that results in data aborts. Fix this again back to 512MB.
>>
>> Fixes: c53beb47f621 ("ARM: dts: NSP: Correct RAM amount for BCM958625HR board")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Acked-by: Jon Mason <jon.mason@broadcom.com>

Applied to devicetree/fixes
-- 
Florian
