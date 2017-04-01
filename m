From: lkp@intel.com (kbuild test robot)
Date: Sat, 1 Apr 2017 14:31:58 +0800
Subject: [PATCH V8 1/6] LIBIO: Introduce a generic PIO mapping method
In-Reply-To: <1490887619-61732-2-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201704011443.8hlP62es%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc4 next-20170331]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/LIBIO-Introduce-a-generic-PIO-mapping-method/20170401-104801
config: m68k-m5475evb_defconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All error/warnings (new ones prefixed by >>):

   lib/logic_pio.c:32:50: error: 'PIO_MAX_SECT' undeclared here (not in a function)
    static struct logic_pio_root logic_pio_root_list[PIO_MAX_SECT] = {
                                                     ^
   lib/logic_pio.c:52:3: error: 'PIO_CPU_MMIO' undeclared here (not in a function)
     [PIO_CPU_MMIO] = {
      ^
   lib/logic_pio.c:52:2: error: array index in initializer not of integer type
     [PIO_CPU_MMIO] = {
     ^
   lib/logic_pio.c:52:2: error: (near initialization for 'logic_pio_root_list')
   lib/logic_pio.c:53:3: error: field name not in record or union initializer
      .sec_head = LIST_HEAD_INIT(logic_pio_root_list[PIO_CPU_MMIO].sec_head),
      ^
   lib/logic_pio.c:53:3: error: (near initialization for 'logic_pio_root_list')
   lib/logic_pio.c:54:3: error: field name not in record or union initializer
      .sec_min = PIO_SECT_MIN(PIO_CPU_MMIO),
      ^
   lib/logic_pio.c:54:3: error: (near initialization for 'logic_pio_root_list')
   lib/logic_pio.c:54:3: error: implicit declaration of function 'PIO_SECT_MIN' [-Werror=implicit-function-declaration]
   lib/logic_pio.c:55:3: error: field name not in record or union initializer
      .sec_max = PIO_SECT_MAX(PIO_CPU_MMIO),
      ^
   lib/logic_pio.c:55:3: error: (near initialization for 'logic_pio_root_list')
   lib/logic_pio.c:55:3: error: implicit declaration of function 'PIO_SECT_MAX' [-Werror=implicit-function-declaration]
   In file included from include/linux/list.h:8:0,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from lib/logic_pio.c:18:
   lib/logic_pio.c: In function 'logic_pio_find_range_byaddr':
>> include/linux/rculist.h:351:49: error: dereferencing pointer to incomplete type
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                                                    ^
   include/linux/kernel.h:852:18: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                     ^
   include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/kernel.h:852:48: warning: initialization from incompatible pointer type
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   include/linux/rculist.h:277:2: note: in expansion of macro 'container_of'
     container_of(lockless_dereference(ptr), type, member)
     ^
   include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
>> include/linux/rculist.h:351:49: error: dereferencing pointer to incomplete type
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                                                    ^
   include/linux/kernel.h:853:3: note: in definition of macro 'container_of'
     (type *)( (char *)__mptr - offsetof(type,member) );})
      ^
   include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   In file included from include/linux/compiler.h:62:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/of.h:18,
                    from lib/logic_pio.c:18:
>> include/linux/rculist.h:351:49: error: dereferencing pointer to incomplete type
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                                                    ^
   include/linux/compiler-gcc.h:161:21: note: in definition of macro '__compiler_offsetof'
     __builtin_offsetof(a, b)
                        ^
   include/linux/kernel.h:853:29: note: in expansion of macro 'offsetof'
     (type *)( (char *)__mptr - offsetof(type,member) );})
                                ^
   include/linux/rculist.h:277:2: note: in expansion of macro 'container_of'
     container_of(lockless_dereference(ptr), type, member)
     ^
   include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   In file included from include/linux/pid.h:4:0,
                    from include/linux/sched.h:13,
                    from arch/m68k/include/asm/pgtable_mm.h:10,
                    from arch/m68k/include/asm/pgtable.h:4,
                    from include/linux/mm.h:68,
                    from lib/logic_pio.c:20:
   include/linux/rculist.h:352:7: error: dereferencing pointer to incomplete type
      &pos->member != (head); \
          ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from lib/logic_pio.c:18:
   include/linux/rculist.h:353:49: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                                    ^
   include/linux/kernel.h:852:18: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                     ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/compiler.h:323:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
>> include/linux/compiler.h:574:26: note: in expansion of macro 'READ_ONCE'
     typeof(p) _________p1 = READ_ONCE(p); \
                             ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/compiler.h:323:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
>> include/linux/compiler.h:574:26: note: in expansion of macro 'READ_ONCE'
     typeof(p) _________p1 = READ_ONCE(p); \
                             ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/compiler.h:323:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
>> include/linux/compiler.h:574:26: note: in expansion of macro 'READ_ONCE'
     typeof(p) _________p1 = READ_ONCE(p); \
                             ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/compiler.h:323:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
>> include/linux/compiler.h:574:26: note: in expansion of macro 'READ_ONCE'
     typeof(p) _________p1 = READ_ONCE(p); \
                             ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/compiler.h:323:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
>> include/linux/compiler.h:574:26: note: in expansion of macro 'READ_ONCE'
     typeof(p) _________p1 = READ_ONCE(p); \
                             ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:27: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                              ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/kernel.h:852:48: warning: initialization makes pointer from integer without a cast
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   include/linux/rculist.h:277:2: note: in expansion of macro 'container_of'
     container_of(lockless_dereference(ptr), type, member)
     ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   include/linux/rculist.h:353:49: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                                    ^
   include/linux/kernel.h:853:3: note: in definition of macro 'container_of'
     (type *)( (char *)__mptr - offsetof(type,member) );})
      ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
   In file included from include/linux/compiler.h:62:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/of.h:18,
                    from lib/logic_pio.c:18:
   include/linux/rculist.h:353:49: error: dereferencing pointer to incomplete type
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
                                                    ^
   include/linux/compiler-gcc.h:161:21: note: in definition of macro '__compiler_offsetof'
     __builtin_offsetof(a, b)
                        ^
   include/linux/kernel.h:853:29: note: in expansion of macro 'offsetof'
     (type *)( (char *)__mptr - offsetof(type,member) );})
                                ^
   include/linux/rculist.h:277:2: note: in expansion of macro 'container_of'
     container_of(lockless_dereference(ptr), type, member)
     ^
   include/linux/rculist.h:353:9: note: in expansion of macro 'list_entry_rcu'
      pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
            ^
   lib/logic_pio.c:77:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(range, &io_range_list, list) {
     ^
>> lib/logic_pio.c:78:13: error: dereferencing pointer to incomplete type
      if (!range->pio_peer) {
                ^
   In file included from include/linux/kernel.h:13:0,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from lib/logic_pio.c:18:
   lib/logic_pio.c:80:11: error: dereferencing pointer to incomplete type
        &range->hw_start);
              ^
   include/linux/printk.h:303:37: note: in definition of macro 'pr_warning'
     printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                        ^
>> lib/logic_pio.c:79:4: note: in expansion of macro 'pr_warn'
       pr_warn("Invalid cpu addr node(%pa) in list!\n",
       ^
   lib/logic_pio.c:83:12: error: dereferencing pointer to incomplete type
      if (range->fwnode != fwnode)
               ^
   lib/logic_pio.c:86:21: error: dereferencing pointer to incomplete type
      if (start >= range->hw_start + range->size ||
                        ^
   lib/logic_pio.c:86:39: error: dereferencing pointer to incomplete type
      if (start >= range->hw_start + range->size ||
                                          ^
   lib/logic_pio.c:87:15: error: dereferencing pointer to incomplete type
       end < range->hw_start)
                  ^
   lib/logic_pio.c:90:20: error: dereferencing pointer to incomplete type
      if (start < range->hw_start ||
                       ^
   lib/logic_pio.c:91:16: error: dereferencing pointer to incomplete type
       end >= range->hw_start + range->size)
                   ^
   lib/logic_pio.c:91:34: error: dereferencing pointer to incomplete type
       end >= range->hw_start + range->size)
                                     ^
   lib/logic_pio.c: In function 'logic_pio_alloc_range':
   lib/logic_pio.c:109:19: error: dereferencing pointer to incomplete type
     idle_start = root->sec_min;
                      ^
   lib/logic_pio.c:110:15: error: dereferencing pointer to incomplete type
     *prev = &root->sec_head;
                  ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from lib/logic_pio.c:18:
>> include/linux/rculist.h:351:49: error: dereferencing pointer to incomplete type
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                                                    ^
   include/linux/kernel.h:852:18: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                     ^
   include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                ^
   lib/logic_pio.c:111:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(entry, &root->sec_head, list) {
     ^
   lib/logic_pio.c:111:38: error: dereferencing pointer to incomplete type
     list_for_each_entry_rcu(entry, &root->sec_head, list) {
                                         ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
>> include/linux/rculist.h:277:15: note: in expansion of macro 'lockless_dereference'
     container_of(lockless_dereference(ptr), type, member)
                  ^
   include/linux/rculist.h:351:13: note: in expansion of macro 'list_entry_rcu'
     for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
                ^
   lib/logic_pio.c:111:2: note: in expansion of macro 'list_for_each_entry_rcu'
     list_for_each_entry_rcu(entry, &root->sec_head, list) {
     ^
   lib/logic_pio.c:111:38: error: dereferencing pointer to incomplete type
     list_for_each_entry_rcu(entry, &root->sec_head, list) {
                                         ^
   include/linux/kernel.h:852:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/compiler.h:323:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^
>> include/linux/compiler.h:574:26: note: in expansion of macro 'READ_ONCE'
     typeof(p) _________p1 = READ_ONCE(p); \
                             ^

vim +351 include/linux/rculist.h

3943f42c Andrey Utkin         2014-11-14  271   * @member:     the name of the list_head within the struct.
72c6a987 Jiri Pirko           2009-04-14  272   *
72c6a987 Jiri Pirko           2009-04-14  273   * This primitive may safely run concurrently with the _rcu list-mutation
72c6a987 Jiri Pirko           2009-04-14  274   * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
72c6a987 Jiri Pirko           2009-04-14  275   */
72c6a987 Jiri Pirko           2009-04-14  276  #define list_entry_rcu(ptr, type, member) \
8db70b13 Patrick Marlier      2015-09-11 @277  	container_of(lockless_dereference(ptr), type, member)
72c6a987 Jiri Pirko           2009-04-14  278  
72c6a987 Jiri Pirko           2009-04-14  279  /**
f88022a4 Michel Machado       2012-04-10  280   * Where are list_empty_rcu() and list_first_entry_rcu()?
f88022a4 Michel Machado       2012-04-10  281   *
f88022a4 Michel Machado       2012-04-10  282   * Implementing those functions following their counterparts list_empty() and
f88022a4 Michel Machado       2012-04-10  283   * list_first_entry() is not advisable because they lead to subtle race
f88022a4 Michel Machado       2012-04-10  284   * conditions as the following snippet shows:
f88022a4 Michel Machado       2012-04-10  285   *
f88022a4 Michel Machado       2012-04-10  286   * if (!list_empty_rcu(mylist)) {
f88022a4 Michel Machado       2012-04-10  287   *	struct foo *bar = list_first_entry_rcu(mylist, struct foo, list_member);
f88022a4 Michel Machado       2012-04-10  288   *	do_something(bar);
f88022a4 Michel Machado       2012-04-10  289   * }
f88022a4 Michel Machado       2012-04-10  290   *
f88022a4 Michel Machado       2012-04-10  291   * The list may not be empty when list_empty_rcu checks it, but it may be when
f88022a4 Michel Machado       2012-04-10  292   * list_first_entry_rcu rereads the ->next pointer.
f88022a4 Michel Machado       2012-04-10  293   *
f88022a4 Michel Machado       2012-04-10  294   * Rereading the ->next pointer is not a problem for list_empty() and
f88022a4 Michel Machado       2012-04-10  295   * list_first_entry() because they would be protected by a lock that blocks
f88022a4 Michel Machado       2012-04-10  296   * writers.
f88022a4 Michel Machado       2012-04-10  297   *
f88022a4 Michel Machado       2012-04-10  298   * See list_first_or_null_rcu for an alternative.
f88022a4 Michel Machado       2012-04-10  299   */
f88022a4 Michel Machado       2012-04-10  300  
f88022a4 Michel Machado       2012-04-10  301  /**
f88022a4 Michel Machado       2012-04-10  302   * list_first_or_null_rcu - get the first element from a list
72c6a987 Jiri Pirko           2009-04-14  303   * @ptr:        the list head to take the element from.
72c6a987 Jiri Pirko           2009-04-14  304   * @type:       the type of the struct this is embedded in.
3943f42c Andrey Utkin         2014-11-14  305   * @member:     the name of the list_head within the struct.
72c6a987 Jiri Pirko           2009-04-14  306   *
f88022a4 Michel Machado       2012-04-10  307   * Note that if the list is empty, it returns NULL.
72c6a987 Jiri Pirko           2009-04-14  308   *
72c6a987 Jiri Pirko           2009-04-14  309   * This primitive may safely run concurrently with the _rcu list-mutation
72c6a987 Jiri Pirko           2009-04-14  310   * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
72c6a987 Jiri Pirko           2009-04-14  311   */
f88022a4 Michel Machado       2012-04-10  312  #define list_first_or_null_rcu(ptr, type, member) \
0adab9b9 Joe Perches          2013-12-05  313  ({ \
0adab9b9 Joe Perches          2013-12-05  314  	struct list_head *__ptr = (ptr); \
7d0ae808 Paul E. McKenney     2015-03-03  315  	struct list_head *__next = READ_ONCE(__ptr->next); \
0adab9b9 Joe Perches          2013-12-05  316  	likely(__ptr != __next) ? list_entry_rcu(__next, type, member) : NULL; \
f88022a4 Michel Machado       2012-04-10  317  })
72c6a987 Jiri Pirko           2009-04-14  318  
82524746 Franck Bui-Huu       2008-05-12  319  /**
ff3c44e6 Tom Herbert          2016-03-07  320   * list_next_or_null_rcu - get the first element from a list
ff3c44e6 Tom Herbert          2016-03-07  321   * @head:	the head for the list.
ff3c44e6 Tom Herbert          2016-03-07  322   * @ptr:        the list head to take the next element from.
ff3c44e6 Tom Herbert          2016-03-07  323   * @type:       the type of the struct this is embedded in.
ff3c44e6 Tom Herbert          2016-03-07  324   * @member:     the name of the list_head within the struct.
ff3c44e6 Tom Herbert          2016-03-07  325   *
ff3c44e6 Tom Herbert          2016-03-07  326   * Note that if the ptr is at the end of the list, NULL is returned.
ff3c44e6 Tom Herbert          2016-03-07  327   *
ff3c44e6 Tom Herbert          2016-03-07  328   * This primitive may safely run concurrently with the _rcu list-mutation
ff3c44e6 Tom Herbert          2016-03-07  329   * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
ff3c44e6 Tom Herbert          2016-03-07  330   */
ff3c44e6 Tom Herbert          2016-03-07  331  #define list_next_or_null_rcu(head, ptr, type, member) \
ff3c44e6 Tom Herbert          2016-03-07  332  ({ \
ff3c44e6 Tom Herbert          2016-03-07  333  	struct list_head *__head = (head); \
ff3c44e6 Tom Herbert          2016-03-07  334  	struct list_head *__ptr = (ptr); \
ff3c44e6 Tom Herbert          2016-03-07  335  	struct list_head *__next = READ_ONCE(__ptr->next); \
ff3c44e6 Tom Herbert          2016-03-07  336  	likely(__next != __head) ? list_entry_rcu(__next, type, \
ff3c44e6 Tom Herbert          2016-03-07  337  						  member) : NULL; \
ff3c44e6 Tom Herbert          2016-03-07  338  })
ff3c44e6 Tom Herbert          2016-03-07  339  
ff3c44e6 Tom Herbert          2016-03-07  340  /**
82524746 Franck Bui-Huu       2008-05-12  341   * list_for_each_entry_rcu	-	iterate over rcu list of given type
82524746 Franck Bui-Huu       2008-05-12  342   * @pos:	the type * to use as a loop cursor.
82524746 Franck Bui-Huu       2008-05-12  343   * @head:	the head for your list.
3943f42c Andrey Utkin         2014-11-14  344   * @member:	the name of the list_head within the struct.
82524746 Franck Bui-Huu       2008-05-12  345   *
82524746 Franck Bui-Huu       2008-05-12  346   * This list-traversal primitive may safely run concurrently with
82524746 Franck Bui-Huu       2008-05-12  347   * the _rcu list-mutation primitives such as list_add_rcu()
82524746 Franck Bui-Huu       2008-05-12  348   * as long as the traversal is guarded by rcu_read_lock().
82524746 Franck Bui-Huu       2008-05-12  349   */
82524746 Franck Bui-Huu       2008-05-12  350  #define list_for_each_entry_rcu(pos, head, member) \
72c6a987 Jiri Pirko           2009-04-14 @351  	for (pos = list_entry_rcu((head)->next, typeof(*pos), member); \
e66eed65 Linus Torvalds       2011-05-19  352  		&pos->member != (head); \
72c6a987 Jiri Pirko           2009-04-14 @353  		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
82524746 Franck Bui-Huu       2008-05-12  354  
82524746 Franck Bui-Huu       2008-05-12  355  /**
69b90729 Alexey Kardashevskiy 2015-12-05  356   * list_entry_lockless - get the struct for this entry

:::::: The code at line 351 was first introduced by commit
:::::: 72c6a9870f901045f2464c3dc6ee8914bfdc07aa rculist.h: introduce list_entry_rcu() and list_first_entry_rcu()

:::::: TO: Jiri Pirko <jpirko@redhat.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 6383 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170401/965db37c/attachment-0001.gz>
