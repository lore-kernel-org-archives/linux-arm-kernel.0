From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 13 Aug 2016 01:01:12 +0800
Subject: [arm64:ttbr0-pan 1/7] arch/arm64/lib/clear_user.S:40: Error: unknown
 mnemonic `user' -- `user(9f, str xzr,[x0],8)'
Message-ID: <201608130106.YbIf6lrl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git ttbr0-pan
head:   d83997941fc4c1162a9084b8b7e98ed6dc130f84
commit: 1209a972f4ffa3cbbb374be6145518f30cd30d6e [1/7] arm64: Factor out PAN enabling/disabling into separate uaccess_* macros
config: arm64-allnoconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 1209a972f4ffa3cbbb374be6145518f30cd30d6e
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/lib/clear_user.S: Assembler messages:
>> arch/arm64/lib/clear_user.S:40: Error: unknown mnemonic `user' -- `user(9f, str xzr,[x0],8)'
>> arch/arm64/lib/clear_user.S:45: Error: unknown mnemonic `user' -- `user(9f, str wzr,[x0],4)'
>> arch/arm64/lib/clear_user.S:49: Error: unknown mnemonic `user' -- `user(9f, strh wzr,[x0],2)'
>> arch/arm64/lib/clear_user.S:53: Error: unknown mnemonic `user' -- `user(9f, strb wzr,[x0],0)'
--
   arch/arm64/lib/copy_template.S: Assembler messages:
>> arch/arm64/lib/copy_template.S:70: Error: unknown mnemonic `user' -- `user(9998f, ldrb tmp1w,[src],#1)'
>> arch/arm64/lib/copy_template.S:74: Error: unknown mnemonic `user' -- `user(9998f, ldrh tmp1w,[src],#2)'
>> arch/arm64/lib/copy_template.S:78: Error: unknown mnemonic `user' -- `user(9998f, ldr tmp1w,[src],#4)'
>> arch/arm64/lib/copy_template.S:82: Error: unknown mnemonic `user' -- `user(9998f, ldr tmp1,[src],#8)'
>> arch/arm64/lib/copy_template.S:102: Error: unknown mnemonic `user' -- `user(9998f, ldp A_l,A_h,[src],#16)'
   arch/arm64/lib/copy_template.S:105: Error: unknown mnemonic `user' -- `user(9998f, ldp A_l,A_h,[src],#16)'
   arch/arm64/lib/copy_template.S:108: Error: unknown mnemonic `user' -- `user(9998f, ldp A_l,A_h,[src],#16)'
   arch/arm64/lib/copy_template.S:123: Error: unknown mnemonic `user' -- `user(9998f, ldr tmp1,[src],#8)'
   arch/arm64/lib/copy_template.S:127: Error: unknown mnemonic `user' -- `user(9998f, ldr tmp1w,[src],#4)'
   arch/arm64/lib/copy_template.S:131: Error: unknown mnemonic `user' -- `user(9998f, ldrh tmp1w,[src],#2)'
   arch/arm64/lib/copy_template.S:135: Error: unknown mnemonic `user' -- `user(9998f, ldrb tmp1w,[src],#1)'
   arch/arm64/lib/copy_template.S:147: Error: unknown mnemonic `user' -- `user(9998f, ldp A_l,A_h,[src],#16)'
>> arch/arm64/lib/copy_template.S:149: Error: unknown mnemonic `user' -- `user(9998f, ldp B_l,B_h,[src],#16)'
>> arch/arm64/lib/copy_template.S:150: Error: unknown mnemonic `user' -- `user(9998f, ldp C_l,C_h,[src],#16)'
>> arch/arm64/lib/copy_template.S:153: Error: unknown mnemonic `user' -- `user(9998f, ldp D_l,D_h,[src],#16)'
   arch/arm64/lib/copy_template.S:167: Error: unknown mnemonic `user' -- `user(9998f, ldp A_l,A_h,[src],#16)'
   arch/arm64/lib/copy_template.S:168: Error: unknown mnemonic `user' -- `user(9998f, ldp B_l,B_h,[src],#16)'
   arch/arm64/lib/copy_template.S:169: Error: unknown mnemonic `user' -- `user(9998f, ldp C_l,C_h,[src],#16)'
   arch/arm64/lib/copy_template.S:170: Error: unknown mnemonic `user' -- `user(9998f, ldp D_l,D_h,[src],#16)'
   arch/arm64/lib/copy_template.S:177: Error: unknown mnemonic `user' -- `user(9998f, ldp A_l,A_h,[src],#16)'
   arch/arm64/lib/copy_template.S:179: Error: unknown mnemonic `user' -- `user(9998f, ldp B_l,B_h,[src],#16)'
   arch/arm64/lib/copy_template.S:181: Error: unknown mnemonic `user' -- `user(9998f, ldp C_l,C_h,[src],#16)'
   arch/arm64/lib/copy_template.S:183: Error: unknown mnemonic `user' -- `user(9998f, ldp D_l,D_h,[src],#16)'
--
   arch/arm64/lib/copy_template.S: Assembler messages:
>> arch/arm64/lib/copy_template.S:70: Error: unknown mnemonic `user' -- `user(9998f, ldrb tmp1w,[src],#1)'
>> arch/arm64/lib/copy_template.S:71: Error: unknown mnemonic `user' -- `user(9998f, strb tmp1w,[dst],#1)'
>> arch/arm64/lib/copy_template.S:74: Error: unknown mnemonic `user' -- `user(9998f, ldrh tmp1w,[src],#2)'
>> arch/arm64/lib/copy_template.S:75: Error: unknown mnemonic `user' -- `user(9998f, strh tmp1w,[dst],#2)'
>> arch/arm64/lib/copy_template.S:78: Error: unknown mnemonic `user' -- `user(9998f, ldr tmp1w,[src],#4)'
>> arch/arm64/lib/copy_template.S:79: Error: unknown mnemonic `user' -- `user(9998f, str tmp1w,[dst],#4)'
>> arch/arm64/lib/copy_template.S:82: Error: unknown mnemonic `user' -- `user(9998f, ldr tmp1,[src],#8)'
>> arch/arm64/lib/copy_template.S:83: Error: unknown mnemonic `user' -- `user(9998f, str tmp1,[dst],#8)'
>> arch/arm64/lib/copy_template.S:102: Error: unknown mnemonic `user' -- `user(9998f, ldp A_l,A_h,[src],#16)'
>> arch/arm64/lib/copy_template.S:103: Error: unknown mnemonic `user' -- `user(9998f, stp A_l,A_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:105: Error: unknown mnemonic `user' -- `user(9998f, ldp A_l,A_h,[src],#16)'
   arch/arm64/lib/copy_template.S:106: Error: unknown mnemonic `user' -- `user(9998f, stp A_l,A_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:108: Error: unknown mnemonic `user' -- `user(9998f, ldp A_l,A_h,[src],#16)'
   arch/arm64/lib/copy_template.S:109: Error: unknown mnemonic `user' -- `user(9998f, stp A_l,A_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:123: Error: unknown mnemonic `user' -- `user(9998f, ldr tmp1,[src],#8)'
   arch/arm64/lib/copy_template.S:124: Error: unknown mnemonic `user' -- `user(9998f, str tmp1,[dst],#8)'
   arch/arm64/lib/copy_template.S:127: Error: unknown mnemonic `user' -- `user(9998f, ldr tmp1w,[src],#4)'
   arch/arm64/lib/copy_template.S:128: Error: unknown mnemonic `user' -- `user(9998f, str tmp1w,[dst],#4)'
   arch/arm64/lib/copy_template.S:131: Error: unknown mnemonic `user' -- `user(9998f, ldrh tmp1w,[src],#2)'
   arch/arm64/lib/copy_template.S:132: Error: unknown mnemonic `user' -- `user(9998f, strh tmp1w,[dst],#2)'
   arch/arm64/lib/copy_template.S:135: Error: unknown mnemonic `user' -- `user(9998f, ldrb tmp1w,[src],#1)'
   arch/arm64/lib/copy_template.S:136: Error: unknown mnemonic `user' -- `user(9998f, strb tmp1w,[dst],#1)'
   arch/arm64/lib/copy_template.S:147: Error: unknown mnemonic `user' -- `user(9998f, ldp A_l,A_h,[src],#16)'
   arch/arm64/lib/copy_template.S:148: Error: unknown mnemonic `user' -- `user(9998f, stp A_l,A_h,[dst],#16)'
>> arch/arm64/lib/copy_template.S:149: Error: unknown mnemonic `user' -- `user(9998f, ldp B_l,B_h,[src],#16)'
>> arch/arm64/lib/copy_template.S:150: Error: unknown mnemonic `user' -- `user(9998f, ldp C_l,C_h,[src],#16)'
>> arch/arm64/lib/copy_template.S:151: Error: unknown mnemonic `user' -- `user(9998f, stp B_l,B_h,[dst],#16)'
>> arch/arm64/lib/copy_template.S:152: Error: unknown mnemonic `user' -- `user(9998f, stp C_l,C_h,[dst],#16)'
>> arch/arm64/lib/copy_template.S:153: Error: unknown mnemonic `user' -- `user(9998f, ldp D_l,D_h,[src],#16)'
>> arch/arm64/lib/copy_template.S:154: Error: unknown mnemonic `user' -- `user(9998f, stp D_l,D_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:167: Error: unknown mnemonic `user' -- `user(9998f, ldp A_l,A_h,[src],#16)'
   arch/arm64/lib/copy_template.S:168: Error: unknown mnemonic `user' -- `user(9998f, ldp B_l,B_h,[src],#16)'
   arch/arm64/lib/copy_template.S:169: Error: unknown mnemonic `user' -- `user(9998f, ldp C_l,C_h,[src],#16)'
   arch/arm64/lib/copy_template.S:170: Error: unknown mnemonic `user' -- `user(9998f, ldp D_l,D_h,[src],#16)'
   arch/arm64/lib/copy_template.S:176: Error: unknown mnemonic `user' -- `user(9998f, stp A_l,A_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:177: Error: unknown mnemonic `user' -- `user(9998f, ldp A_l,A_h,[src],#16)'
   arch/arm64/lib/copy_template.S:178: Error: unknown mnemonic `user' -- `user(9998f, stp B_l,B_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:179: Error: unknown mnemonic `user' -- `user(9998f, ldp B_l,B_h,[src],#16)'
   arch/arm64/lib/copy_template.S:180: Error: unknown mnemonic `user' -- `user(9998f, stp C_l,C_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:181: Error: unknown mnemonic `user' -- `user(9998f, ldp C_l,C_h,[src],#16)'
   arch/arm64/lib/copy_template.S:182: Error: unknown mnemonic `user' -- `user(9998f, stp D_l,D_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:183: Error: unknown mnemonic `user' -- `user(9998f, ldp D_l,D_h,[src],#16)'
   arch/arm64/lib/copy_template.S:186: Error: unknown mnemonic `user' -- `user(9998f, stp A_l,A_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:187: Error: unknown mnemonic `user' -- `user(9998f, stp B_l,B_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:188: Error: unknown mnemonic `user' -- `user(9998f, stp C_l,C_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:189: Error: unknown mnemonic `user' -- `user(9998f, stp D_l,D_h,[dst],#16)'
--
   arch/arm64/lib/copy_template.S: Assembler messages:
>> arch/arm64/lib/copy_template.S:71: Error: unknown mnemonic `user' -- `user(9998f, strb tmp1w,[dst],#1)'
>> arch/arm64/lib/copy_template.S:75: Error: unknown mnemonic `user' -- `user(9998f, strh tmp1w,[dst],#2)'
>> arch/arm64/lib/copy_template.S:79: Error: unknown mnemonic `user' -- `user(9998f, str tmp1w,[dst],#4)'
>> arch/arm64/lib/copy_template.S:83: Error: unknown mnemonic `user' -- `user(9998f, str tmp1,[dst],#8)'
>> arch/arm64/lib/copy_template.S:103: Error: unknown mnemonic `user' -- `user(9998f, stp A_l,A_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:106: Error: unknown mnemonic `user' -- `user(9998f, stp A_l,A_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:109: Error: unknown mnemonic `user' -- `user(9998f, stp A_l,A_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:124: Error: unknown mnemonic `user' -- `user(9998f, str tmp1,[dst],#8)'
   arch/arm64/lib/copy_template.S:128: Error: unknown mnemonic `user' -- `user(9998f, str tmp1w,[dst],#4)'
   arch/arm64/lib/copy_template.S:132: Error: unknown mnemonic `user' -- `user(9998f, strh tmp1w,[dst],#2)'
   arch/arm64/lib/copy_template.S:136: Error: unknown mnemonic `user' -- `user(9998f, strb tmp1w,[dst],#1)'
   arch/arm64/lib/copy_template.S:148: Error: unknown mnemonic `user' -- `user(9998f, stp A_l,A_h,[dst],#16)'
>> arch/arm64/lib/copy_template.S:151: Error: unknown mnemonic `user' -- `user(9998f, stp B_l,B_h,[dst],#16)'
>> arch/arm64/lib/copy_template.S:152: Error: unknown mnemonic `user' -- `user(9998f, stp C_l,C_h,[dst],#16)'
>> arch/arm64/lib/copy_template.S:154: Error: unknown mnemonic `user' -- `user(9998f, stp D_l,D_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:176: Error: unknown mnemonic `user' -- `user(9998f, stp A_l,A_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:178: Error: unknown mnemonic `user' -- `user(9998f, stp B_l,B_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:180: Error: unknown mnemonic `user' -- `user(9998f, stp C_l,C_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:182: Error: unknown mnemonic `user' -- `user(9998f, stp D_l,D_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:186: Error: unknown mnemonic `user' -- `user(9998f, stp A_l,A_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:187: Error: unknown mnemonic `user' -- `user(9998f, stp B_l,B_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:188: Error: unknown mnemonic `user' -- `user(9998f, stp C_l,C_h,[dst],#16)'
   arch/arm64/lib/copy_template.S:189: Error: unknown mnemonic `user' -- `user(9998f, stp D_l,D_h,[dst],#16)'

vim +40 arch/arm64/lib/clear_user.S

0aea86a2 Catalin Marinas 2012-03-05  34  ENTRY(__clear_user)
1209a972 Catalin Marinas 2016-07-01  35  	uaccess_enable x2, x3, x4
0aea86a2 Catalin Marinas 2012-03-05  36  	mov	x2, x1			// save the size for fixup return
0aea86a2 Catalin Marinas 2012-03-05  37  	subs	x1, x1, #8
0aea86a2 Catalin Marinas 2012-03-05  38  	b.mi	2f
0aea86a2 Catalin Marinas 2012-03-05  39  1:
57f4959b James Morse     2016-02-05 @40  uao_user_alternative 9f, str, sttr, xzr, x0, 8
0aea86a2 Catalin Marinas 2012-03-05  41  	subs	x1, x1, #8
0aea86a2 Catalin Marinas 2012-03-05  42  	b.pl	1b
0aea86a2 Catalin Marinas 2012-03-05  43  2:	adds	x1, x1, #4
0aea86a2 Catalin Marinas 2012-03-05  44  	b.mi	3f
57f4959b James Morse     2016-02-05 @45  uao_user_alternative 9f, str, sttr, wzr, x0, 4
0aea86a2 Catalin Marinas 2012-03-05  46  	sub	x1, x1, #4
0aea86a2 Catalin Marinas 2012-03-05  47  3:	adds	x1, x1, #2
0aea86a2 Catalin Marinas 2012-03-05  48  	b.mi	4f
57f4959b James Morse     2016-02-05 @49  uao_user_alternative 9f, strh, sttrh, wzr, x0, 2
0aea86a2 Catalin Marinas 2012-03-05  50  	sub	x1, x1, #2
0aea86a2 Catalin Marinas 2012-03-05  51  4:	adds	x1, x1, #1
0aea86a2 Catalin Marinas 2012-03-05  52  	b.mi	5f
57f4959b James Morse     2016-02-05 @53  uao_user_alternative 9f, strb, sttrb, wzr, x0, 0
0aea86a2 Catalin Marinas 2012-03-05  54  5:	mov	x0, #0
1209a972 Catalin Marinas 2016-07-01  55  	uaccess_disable x2
0aea86a2 Catalin Marinas 2012-03-05  56  	ret

:::::: The code at line 40 was first introduced by commit
:::::: 57f4959bad0a154aeca125b7d38d1d9471a12422 arm64: kernel: Add support for User Access Override

:::::: TO: James Morse <james.morse@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 6126 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160813/32d7e87c/attachment-0001.obj>
