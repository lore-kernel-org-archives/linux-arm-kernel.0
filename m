From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 21 Oct 2013 20:14:56 +0200
Subject: [REGRESSION?] sensors and fancontrol not seeing armada_thermal on
 3.12-rc series
In-Reply-To: <20131021091739.739142e8@endymion.delvare> (Jean Delvare's
 message of "Mon, 21 Oct 2013 09:17:39 +0200")
References: <87ppqzolsu.fsf@natisbad.org>
 <20131021091739.739142e8@endymion.delvare>
Message-ID: <87r4be1of3.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

Jean Delvare <khali@linux-fr.org> writes:

> Can you please share the full output of "strace sensors"? This will
> help me understand which exact code paths are taken in libsensors.

The 'strace sensors' output on a 3.12-rc6 is below, followed by the
output of the same command on a 3.11.6.

-3.12-rc6--8<--------------------------------------------------------

execve("/usr/bin/sensors", ["sensors"], [/* 13 vars */]) = 0
brk(0)                                  = 0xf63000
uname({sys="Linux", node="mood", ...})  = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f15000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=24842, ...}) = 0
mmap2(NULL, 24842, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb6ee9000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/arm-linux-gnueabi/libsensors.so.4", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\210\27\0\0004\0\0\0"..., 512) = 512
lseek(3, 53908, SEEK_SET)               = 53908
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1040) = 1040
lseek(3, 53644, SEEK_SET)               = 53644
read(3, "A)\0\0\0aeabi\0\1\37\0\0\0\0054T\0\6\2\10\1\t\1\22\4\24\1\25\1"..., 42) = 42
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f14000
fstat64(3, {st_mode=S_IFREG|0644, st_size=54948, ...}) = 0
mmap2(NULL, 86952, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6ed3000
mprotect(0xb6ee0000, 28672, PROT_NONE)  = 0
mmap2(0xb6ee7000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc) = 0xb6ee7000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/arm-linux-gnueabi/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0h\202\1\0004\0\0\0"..., 512) = 512
lseek(3, 1240084, SEEK_SET)             = 1240084
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2840) = 2840
lseek(3, 1236484, SEEK_SET)             = 1236484
read(3, "A)\0\0\0aeabi\0\1\37\0\0\0\0054T\0\6\2\10\1\t\1\22\4\23\1\24\1"..., 42) = 42
fstat64(3, {st_mode=S_IFREG|0755, st_size=1242924, ...}) = 0
mmap2(NULL, 1279368, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6d9a000
mprotect(0xb6ec5000, 32768, PROT_NONE)  = 0
mmap2(0xb6ecd000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12b) = 0xb6ecd000
mmap2(0xb6ed0000, 9608, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb6ed0000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/arm-linux-gnueabi/libm.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0000<\0\0004\0\0\0"..., 512) = 512
lseek(3, 659912, SEEK_SET)              = 659912
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1160) = 1160
lseek(3, 659588, SEEK_SET)              = 659588
read(3, "A)\0\0\0aeabi\0\1\37\0\0\0\0054T\0\6\2\10\1\t\1\22\4\23\1\24\1"..., 42) = 42
fstat64(3, {st_mode=S_IFREG|0644, st_size=661072, ...}) = 0
mmap2(NULL, 692364, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6cf0000
mprotect(0xb6d91000, 28672, PROT_NONE)  = 0
mmap2(0xb6d98000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa0) = 0xb6d98000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f13000
set_tls(0xb6f134c0, 0xb6f13b98, 0xb6f18050, 0xb6f134c0, 0xb6f18050) = 0
mprotect(0xb6ecd000, 8192, PROT_READ)   = 0
mprotect(0xb6d98000, 4096, PROT_READ)   = 0
mprotect(0xb6ee7000, 4096, PROT_READ)   = 0
mprotect(0x14000, 4096, PROT_READ)      = 0
mprotect(0xb6f17000, 4096, PROT_READ)   = 0
munmap(0xb6ee9000, 24842)               = 0
brk(0)                                  = 0xf63000
brk(0xf84000)                           = 0xf84000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1607632, ...}) = 0
mmap2(NULL, 1607632, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb6b67000
close(3)                                = 0
statfs("/sys", {f_type="SYSFS_MAGIC", f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={0, 0}, f_namelen=255, f_frsize=4096}) = 0
openat(AT_FDCWD, "/sys/class/i2c-adapter", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 3
fcntl64(3, F_GETFD)                     = 0x1 (flags FD_CLOEXEC)
getdents(3, /* 3 entries */, 32768)     = 52
open("/sys/class/i2c-adapter/i2c-0/name", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f12000
read(4, "mv64xxx_i2c adapter\n", 4096)  = 20
close(4)                                = 0
munmap(0xb6f12000, 4096)                = 0
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
openat(AT_FDCWD, "/sys/class/hwmon", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 3
getdents(3, /* 4 entries */, 32768)     = 72
readlink("/sys/class/hwmon/hwmon0/device", "../../../0-003e"..., 254) = 15
open("/sys/class/hwmon/hwmon0/name", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/class/hwmon/hwmon0/device/name", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f12000
read(4, "g762\n", 4096)                 = 5
close(4)                                = 0
munmap(0xb6f12000, 4096)                = 0
readlink("/sys/class/hwmon/hwmon0/device/subsystem", "../../../../../../bus/i2c", 254) = 25
open("/sys/class/i2c-adapter/i2c-0/device/name", O_RDONLY) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/sys/class/hwmon/hwmon0/device", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 4
brk(0xfab000)                           = 0xfab000
getdents(4, /* 17 entries */, 32768)    = 356
stat64("/sys/class/hwmon/hwmon0/device/fan1_pulses", {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
stat64("/sys/class/hwmon/hwmon0/device/fan1_div", {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
stat64("/sys/class/hwmon/hwmon0/device/fan1_alarm", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
stat64("/sys/class/hwmon/hwmon0/device/fan1_fault", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
stat64("/sys/class/hwmon/hwmon0/device/fan1_input", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
getdents(4, /* 0 entries */, 32768)     = 0
close(4)                                = 0
readlink("/sys/class/hwmon/hwmon1/device", "../../thermal_zone0"..., 254) = 19
open("/sys/class/hwmon/hwmon1/name", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f12000
read(4, "armada_thermal\n", 4096)       = 15
close(4)                                = 0
munmap(0xb6f12000, 4096)                = 0
readlink("/sys/class/hwmon/hwmon1/device/subsystem", "../../../../class/thermal", 254) = 25
open("/sys/class/hwmon/hwmon1/device/name", O_RDONLY) = -1 ENOENT (No such file or directory)
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
open("/etc/sensors3.conf", O_RDONLY)    = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbebc4af4) = -1 ENOTTY (Inappropriate ioctl for device)
fstat64(3, {st_mode=S_IFREG|0644, st_size=10344, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f12000
read(3, "# libsensors configuration file\n"..., 8192) = 8192
read(3, " label in4 \"+12V\"\n    label in5 "..., 8192) = 2152
read(3, "", 4096)                       = 0
read(3, "", 8192)                       = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbebc3b04) = -1 ENOTTY (Inappropriate ioctl for device)
close(3)                                = 0
munmap(0xb6f12000, 4096)                = 0
openat(AT_FDCWD, "/etc/sensors.d", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 3
getdents(3, /* 3 entries */, 32768)     = 56
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
open("/usr/lib/arm-linux-gnueabi/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=26260, ...}) = 0
mmap2(NULL, 26260, PROT_READ, MAP_SHARED, 3, 0) = 0xb6ee9000
close(3)                                = 0
open("/usr/lib/arm-linux-gnueabi/gconv/ISO8859-1.so", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\354\3\0\0004\0\0\0"..., 512) = 512
lseek(3, 8548, SEEK_SET)                = 8548
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1080) = 1080
lseek(3, 8248, SEEK_SET)                = 8248
read(3, "A)\0\0\0aeabi\0\1\37\0\0\0\0054T\0\6\2\10\1\t\1\22\4\23\1\24\1"..., 42) = 42
fstat64(3, {st_mode=S_IFREG|0644, st_size=9628, ...}) = 0
mmap2(NULL, 41020, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6b5c000
mprotect(0xb6b5e000, 28672, PROT_NONE)  = 0
mmap2(0xb6b65000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb6b65000
close(3)                                = 0
mprotect(0xb6b65000, 4096, PROT_READ)   = 0
fstat64(1, {st_mode=S_IFREG|0644, st_size=9216, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f12000
open("/sys/class/hwmon/hwmon0/device/fan1_label", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/class/hwmon/hwmon0/device/fan1_label", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/class/hwmon/hwmon0/device/fan1_fault", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f11000
read(3, "0\n", 4096)                    = 2
close(3)                                = 0
munmap(0xb6f11000, 4096)                = 0
open("/sys/class/hwmon/hwmon0/device/fan1_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f11000
read(3, "1536\n", 4096)                 = 5
close(3)                                = 0
munmap(0xb6f11000, 4096)                = 0
open("/sys/class/hwmon/hwmon0/device/fan1_div", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f11000
read(3, "1\n", 4096)                    = 2
close(3)                                = 0
munmap(0xb6f11000, 4096)                = 0
open("/sys/class/hwmon/hwmon0/device/fan1_alarm", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f11000
read(3, "0\n", 4096)                    = 2
close(3)                                = 0
munmap(0xb6f11000, 4096)                = 0
write(1, "g762-i2c-0-3e\nAdapter: mv64xxx_i"..., 77g762-i2c-0-3e
Adapter: mv64xxx_i2c adapter
fan1:        1536 RPM  (div = 1)

) = 77
exit_group(0)                           = ?





-3.11.6--8<--------------------------------------------------------

execve("/usr/bin/sensors", ["sensors"], [/* 13 vars */]) = 0
brk(0)                                  = 0x1ae9000
uname({sys="Linux", node="mood", ...})  = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe7000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=24842, ...}) = 0
mmap2(NULL, 24842, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb6fbb000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/arm-linux-gnueabi/libsensors.so.4", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\210\27\0\0004\0\0\0"..., 512) = 512
lseek(3, 53908, SEEK_SET)               = 53908
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1040) = 1040
lseek(3, 53644, SEEK_SET)               = 53644
read(3, "A)\0\0\0aeabi\0\1\37\0\0\0\0054T\0\6\2\10\1\t\1\22\4\24\1\25\1"..., 42) = 42
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe6000
fstat64(3, {st_mode=S_IFREG|0644, st_size=54948, ...}) = 0
mmap2(NULL, 86952, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6fa5000
mprotect(0xb6fb2000, 28672, PROT_NONE)  = 0
mmap2(0xb6fb9000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc) = 0xb6fb9000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/arm-linux-gnueabi/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0h\202\1\0004\0\0\0"..., 512) = 512
lseek(3, 1240084, SEEK_SET)             = 1240084
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 2840) = 2840
lseek(3, 1236484, SEEK_SET)             = 1236484
read(3, "A)\0\0\0aeabi\0\1\37\0\0\0\0054T\0\6\2\10\1\t\1\22\4\23\1\24\1"..., 42) = 42
fstat64(3, {st_mode=S_IFREG|0755, st_size=1242924, ...}) = 0
mmap2(NULL, 1279368, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6e6c000
mprotect(0xb6f97000, 32768, PROT_NONE)  = 0
mmap2(0xb6f9f000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12b) = 0xb6f9f000
mmap2(0xb6fa2000, 9608, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb6fa2000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/arm-linux-gnueabi/libm.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0000<\0\0004\0\0\0"..., 512) = 512
lseek(3, 659912, SEEK_SET)              = 659912
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1160) = 1160
lseek(3, 659588, SEEK_SET)              = 659588
read(3, "A)\0\0\0aeabi\0\1\37\0\0\0\0054T\0\6\2\10\1\t\1\22\4\23\1\24\1"..., 42) = 42
fstat64(3, {st_mode=S_IFREG|0644, st_size=661072, ...}) = 0
mmap2(NULL, 692364, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6dc2000
mprotect(0xb6e63000, 28672, PROT_NONE)  = 0
mmap2(0xb6e6a000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa0) = 0xb6e6a000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe5000
set_tls(0xb6fe54c0, 0xb6fe5b98, 0xb6fea050, 0xb6fe54c0, 0xb6fea050) = 0
mprotect(0xb6f9f000, 8192, PROT_READ)   = 0
mprotect(0xb6e6a000, 4096, PROT_READ)   = 0
mprotect(0xb6fb9000, 4096, PROT_READ)   = 0
mprotect(0x14000, 4096, PROT_READ)      = 0
mprotect(0xb6fe9000, 4096, PROT_READ)   = 0
munmap(0xb6fbb000, 24842)               = 0
brk(0)                                  = 0x1ae9000
brk(0x1b0a000)                          = 0x1b0a000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1607632, ...}) = 0
mmap2(NULL, 1607632, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb6c39000
close(3)                                = 0
statfs("/sys", {f_type="SYSFS_MAGIC", f_bsize=4096, f_blocks=0, f_bfree=0, f_bavail=0, f_files=0, f_ffree=0, f_fsid={0, 0}, f_namelen=255, f_frsize=4096}) = 0
openat(AT_FDCWD, "/sys/class/i2c-adapter", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 3
fcntl64(3, F_GETFD)                     = 0x1 (flags FD_CLOEXEC)
getdents(3, /* 3 entries */, 32768)     = 52
open("/sys/class/i2c-adapter/i2c-0/name", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe4000
read(4, "mv64xxx_i2c adapter\n", 4096)  = 20
close(4)                                = 0
munmap(0xb6fe4000, 4096)                = 0
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
openat(AT_FDCWD, "/sys/class/hwmon", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 3
getdents(3, /* 4 entries */, 32768)     = 72
readlink("/sys/class/hwmon/hwmon0/device", "../../../0-003e"..., 254) = 15
open("/sys/class/hwmon/hwmon0/name", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/class/hwmon/hwmon0/device/name", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe4000
read(4, "g762\n", 4096)                 = 5
close(4)                                = 0
munmap(0xb6fe4000, 4096)                = 0
readlink("/sys/class/hwmon/hwmon0/device/subsystem", "../../../../../../bus/i2c", 254) = 25
open("/sys/class/i2c-adapter/i2c-0/device/name", O_RDONLY) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/sys/class/hwmon/hwmon0/device", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 4
brk(0x1b31000)                          = 0x1b31000
getdents(4, /* 17 entries */, 32768)    = 356
stat64("/sys/class/hwmon/hwmon0/device/fan1_pulses", {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
stat64("/sys/class/hwmon/hwmon0/device/fan1_div", {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
stat64("/sys/class/hwmon/hwmon0/device/fan1_alarm", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
stat64("/sys/class/hwmon/hwmon0/device/fan1_fault", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
stat64("/sys/class/hwmon/hwmon0/device/fan1_input", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
getdents(4, /* 0 entries */, 32768)     = 0
close(4)                                = 0
readlink("/sys/class/hwmon/hwmon1/device", 0xbeb3596c, 254) = -1 ENOENT (No such file or directory)
open("/sys/class/hwmon/hwmon1/name", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe4000
read(4, "armada_thermal\n", 4096)       = 15
close(4)                                = 0
munmap(0xb6fe4000, 4096)                = 0
openat(AT_FDCWD, "/sys/class/hwmon/hwmon1", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 4
getdents(4, /* 6 entries */, 32768)     = 116
stat64("/sys/class/hwmon/hwmon1/temp1_input", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
getdents(4, /* 0 entries */, 32768)     = 0
close(4)                                = 0
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
open("/etc/sensors3.conf", O_RDONLY)    = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbeb35af4) = -1 ENOTTY (Inappropriate ioctl for device)
fstat64(3, {st_mode=S_IFREG|0644, st_size=10344, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe4000
read(3, "# libsensors configuration file\n"..., 8192) = 8192
read(3, " label in4 \"+12V\"\n    label in5 "..., 8192) = 2152
read(3, "", 4096)                       = 0
read(3, "", 8192)                       = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbeb34b04) = -1 ENOTTY (Inappropriate ioctl for device)
close(3)                                = 0
munmap(0xb6fe4000, 4096)                = 0
openat(AT_FDCWD, "/etc/sensors.d", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 3
getdents(3, /* 3 entries */, 32768)     = 56
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
open("/usr/lib/arm-linux-gnueabi/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=26260, ...}) = 0
mmap2(NULL, 26260, PROT_READ, MAP_SHARED, 3, 0) = 0xb6fbb000
close(3)                                = 0
open("/usr/lib/arm-linux-gnueabi/gconv/ISO8859-1.so", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\354\3\0\0004\0\0\0"..., 512) = 512
lseek(3, 8548, SEEK_SET)                = 8548
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1080) = 1080
lseek(3, 8248, SEEK_SET)                = 8248
read(3, "A)\0\0\0aeabi\0\1\37\0\0\0\0054T\0\6\2\10\1\t\1\22\4\23\1\24\1"..., 42) = 42
fstat64(3, {st_mode=S_IFREG|0644, st_size=9628, ...}) = 0
mmap2(NULL, 41020, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6c2e000
mprotect(0xb6c30000, 28672, PROT_NONE)  = 0
mmap2(0xb6c37000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb6c37000
close(3)                                = 0
mprotect(0xb6c37000, 4096, PROT_READ)   = 0
fstat64(1, {st_mode=S_IFREG|0644, st_size=9385, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe4000
open("/sys/class/hwmon/hwmon0/device/fan1_label", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/class/hwmon/hwmon0/device/fan1_label", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/class/hwmon/hwmon0/device/fan1_fault", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe3000
read(3, "0\n", 4096)                    = 2
close(3)                                = 0
munmap(0xb6fe3000, 4096)                = 0
open("/sys/class/hwmon/hwmon0/device/fan1_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe3000
read(3, "3510\n", 4096)                 = 5
close(3)                                = 0
munmap(0xb6fe3000, 4096)                = 0
open("/sys/class/hwmon/hwmon0/device/fan1_div", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe3000
read(3, "1\n", 4096)                    = 2
close(3)                                = 0
munmap(0xb6fe3000, 4096)                = 0
open("/sys/class/hwmon/hwmon0/device/fan1_alarm", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe3000
read(3, "0\n", 4096)                    = 2
close(3)                                = 0
munmap(0xb6fe3000, 4096)                = 0
open("/sys/class/hwmon/hwmon1/temp1_label", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/class/hwmon/hwmon1/temp1_label", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/class/hwmon/hwmon1/temp1_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe3000
read(3, "42893\n", 4096)                = 6
close(3)                                = 0
munmap(0xb6fe3000, 4096)                = 0
open("/sys/class/hwmon/hwmon1/temp1_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe3000
read(3, "42893\n", 4096)                = 6
close(3)                                = 0
munmap(0xb6fe3000, 4096)                = 0
brk(0x1b13000)                          = 0x1b13000
write(1, "g762-i2c-0-3e\nAdapter: mv64xxx_i"..., 152g762-i2c-0-3e
Adapter: mv64xxx_i2c adapter
fan1:        3510 RPM  (div = 1)

armada_thermal-virtual-0
Adapter: Virtual device
temp1:        +42.9?C  

) = 152
exit_group(0)                           = ?
