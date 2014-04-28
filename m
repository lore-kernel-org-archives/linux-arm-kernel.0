From: wangsen.linux@gmail.com (sen wang)
Date: Mon, 28 Apr 2014 17:42:39 +0800
Subject: =?UTF-8?B?bWFwX2xvd21lbeKAiy0tLXNvbWV0aGluZyBpcyB3cm9uZyBmb3IgTFBBRT8=?=
Message-ID: <CAJwrfJQBG8xUf6Jxu9xvVb0zgWkoa_gD3ueQz3x5z325+b7t6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mm/mmu.c

static void __init map_lowmem(void)
{
 ...
 unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
 unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);

 /*the result of the "round_down" "round_down" is 64bit. but the
"unsigned long" on a cortex A15/A9/A8/... is 32bit!*/

...

/*and the "end", "start" is also 64bit......,  for a machine with
phymem >4G,....!*/

if (end < kernel_x_start || start >= kernel_x_end) {...

}

...


}
