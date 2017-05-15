From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 16 May 2017 02:43:01 +0800
Subject: [stericsson:ux500-crypto-hash 1/1] crypto/testmgr.c:452:12: warning:
 passing argument 1 of 'hexdump' discards 'const' qualifier from
 pointer target type
Message-ID: <201705160257.HcoulGtq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-crypto-hash
head:   2eb19141cc6db5ab79471c7bbbe5d35f49025307
commit: 2eb19141cc6db5ab79471c7bbbe5d35f49025307 [1/1] slask
config: s390-gcov_defconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2eb19141cc6db5ab79471c7bbbe5d35f49025307
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

All warnings (new ones prefixed by >>):

   crypto/testmgr.c: In function '__test_hash':
>> crypto/testmgr.c:452:12: warning: passing argument 1 of 'hexdump' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
       hexdump(template[i].digest, crypto_ahash_digestsize(tfm));
               ^~~~~~~~
   crypto/testmgr.c:151:13: note: expected 'unsigned char *' but argument is of type 'const char * const'
    static void hexdump(unsigned char *buf, unsigned int len)
                ^~~~~~~

vim +452 crypto/testmgr.c

   436					break;
   437				/* fall through */
   438			default:
   439				printk(KERN_ERR "alg: hash: digest failed "
   440				       "on chunking test %d for %s: "
   441				       "ret=%d\n", j, algo, -ret);
   442				goto out;
   443			}
   444	
   445			if (memcmp(result, template[i].digest,
   446				   crypto_ahash_digestsize(tfm))) {
   447				printk(KERN_ERR "alg: hash: Chunking test %d "
   448				       "FAILED for %s\n", j, algo);
   449				printk(KERN_ERR "result:\n");
   450				hexdump(result, crypto_ahash_digestsize(tfm));
   451				printk(KERN_ERR "expected:\n");
 > 452				hexdump(template[i].digest, crypto_ahash_digestsize(tfm));
   453				ret = -EINVAL;
   454				goto out;
   455			} else {
   456				printk(KERN_ERR "alg: hash: Chunking test %d SUCCEEDED for %s\n",
   457				       j, algo);
   458			}
   459		}
   460	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 17061 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170516/c8ab4397/attachment-0001.gz>
