From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 2 Jan 2014 12:13:59 +0200
Subject: ARM: mm: Could I change module space size or place modules in
 vmalloc area?
In-Reply-To: <002001cf07a1$fd4bdc10$f7e39430$@lge.com>
References: <002001cf07a1$fd4bdc10$f7e39430$@lge.com>
Message-ID: <20140102101359.GU6589@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gioh,

On Thu, Jan 02, 2014 at 07:04:13PM +0900, Gioh Kim wrote:
> I run out of module space because I have several big driver modules.
> I know I can strip the modules to decrease size but I need debug info now.

Are you sure you need the debug info in kernel memory? I don't think the 
kernel is actually able to parse DWARF. You can load stripped binaries into 
the kernel, and still use the debug info with whatever tool you have.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
