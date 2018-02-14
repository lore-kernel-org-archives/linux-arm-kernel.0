From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Feb 2018 08:50:16 -0800
Subject: [PATCH 2/2] mmc: bcm2835: print some informational messages
 during reset
In-Reply-To: <57ff1e429a7fc12300a3cca0c5e9a637beed0d3a.1518619058.git.msuchanek@suse.de>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de><97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <57ff1e429a7fc12300a3cca0c5e9a637beed0d3a.1518619058.git.msuchanek@suse.de>
Message-ID: <F404E9C8-AE64-4B36-AD1B-911BD3C33946@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On February 14, 2018 6:38:58 AM PST, Michal Suchanek <msuchanek@suse.de> wrote:
>The previous patch does reset during hardware error so make the reset
>progress more visible.

Based on your previous email it looks like this can happen quite frequently so we might be spamming the kernel log with such reset messages. Turning this into a debug print would not be great either, how about a custom sysfs attribute counting the number of times a reset was done?

We should ideally root cause this but I am sure we can.

-- 
Florian
