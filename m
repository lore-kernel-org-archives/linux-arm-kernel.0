From: zsadecki@itwatchdogs.com (Zach Sadecki)
Date: Tue, 13 Mar 2012 09:59:39 -0500
Subject: [PATCH v1 1/5] ARM: imx28: add basic dt support
In-Reply-To: <4F5F5B3F.2000303@gmail.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <4F5F5B3F.2000303@gmail.com>
Message-ID: <4F5F60DB.9090801@itwatchdogs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2012 09:35 AM, Rob Herring wrote:
> +	ahb at 80080000 {
> +		fec at 800f0000 {
> Use generic names: ethernet at 800f0000
Generic is good, but consistency is better, IMHO.  grepping existing dts 
files in 3.2.9 finds 6 instances of "fec@" and 0 instances of "ethernet@"
>> +			uart1: uart at 80074000 {
> Use generic names: uart1: serial at ...
Same comment here, but unfortunately there is already inconsistency in 
existing files...  25 instances of "serial@" and 35 instances of "uart@"
